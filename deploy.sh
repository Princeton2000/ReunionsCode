#!/usr/bin/env bash
#
# deploy.sh — Build and deploy the Princeton Class of 2000 reunions site.
#
# Flow:  build (Ignite → docs/)  →  push STAGING  →  rsync docs/ to PROD  →  push PROD
#
#   STAGING repo : Princeton2000/ReunionsCode   → https://staging.princeton2000.org
#   PROD    repo : Princeton2000/reunions2025    → https://reunions.princeton2000.org
#
# The staging repo holds the Ignite *source* and its built docs/ (CNAME = staging…).
# Prod is docs-only at its root, with its own CNAME (reunions…) that is never overwritten.
#
# Usage:
#   ./deploy.sh                 # build, deploy staging, then (after confirm) prod
#   ./deploy.sh --stage-only    # build + deploy staging, stop before prod
#   ./deploy.sh --prod-only     # skip build/staging; sync current docs/ and deploy prod
#   ./deploy.sh --dry-run       # show every action; commit/push/rsync run read-only
#   ./deploy.sh --skip-build    # reuse existing docs/ (don't run ignite build)
#   ./deploy.sh -y              # don't prompt before the prod step
#   ./deploy.sh --prune         # let rsync DELETE prod files absent from a fresh docs/
#   ./deploy.sh --force         # push with --force-with-lease (for diverged remotes)
#   ./deploy.sh -m "message"    # custom commit message
#
# By default the sync is ADDITIVE (like the original `rsync -av`): it never
# removes files from prod, so a stale/partial build can't wipe live pages.
# Use --prune only when you know the build is complete and you want to remove
# pages that no longer exist in the site. Always preview it with --dry-run first.
#
set -euo pipefail

# --- Locations (override via env if the tree ever moves) ---------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAGING_DIR="${REUNIONS_STAGING_DIR:-$SCRIPT_DIR}"
PROD_DIR="${REUNIONS_PROD_DIR:-$(cd "$SCRIPT_DIR/../../../reunions2025" 2>/dev/null && pwd || true)}"

STAGING_REMOTE_MATCH="ReunionsCode"
PROD_REMOTE_MATCH="reunions2025"
STAGING_URL="https://staging.princeton2000.org"
PROD_URL="https://reunions.princeton2000.org"

# Paths protected from rsync --delete (kept in prod even though not in docs/).
RSYNC_EXCLUDES=( --exclude='.git' --exclude='CNAME' --exclude='development-guidelines' --exclude='.DS_Store' )

# --- Flags -------------------------------------------------------------------
DRY_RUN=false; STAGE_ONLY=false; PROD_ONLY=false; SKIP_BUILD=false
ASSUME_YES=false; FORCE=false; PRUNE=false; MSG=""

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run)    DRY_RUN=true ;;
    --stage-only) STAGE_ONLY=true ;;
    --prod-only)  PROD_ONLY=true; SKIP_BUILD=true ;;
    --skip-build) SKIP_BUILD=true ;;
    --prune)      PRUNE=true ;;
    -y|--yes)     ASSUME_YES=true ;;
    --force)      FORCE=true ;;
    -m|--message) MSG="${2:-}"; shift ;;
    -h|--help)    sed -n '2,30p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done
MSG="${MSG:-Deploy $(date '+%Y-%m-%d %H:%M')}"

# --- Pretty output -----------------------------------------------------------
c() { printf '\033[%sm' "$1"; }
log()  { printf "$(c '1;34')▶ %s$(c 0)\n" "$*"; }
ok()   { printf "$(c '1;32')✓ %s$(c 0)\n" "$*"; }
warn() { printf "$(c '1;33')⚠ %s$(c 0)\n" "$*"; }
die()  { printf "$(c '1;31')✗ %s$(c 0)\n" "$*" >&2; exit 1; }
run()  { if $DRY_RUN; then printf "$(c '2')  [dry-run] %s$(c 0)\n" "$*"; else eval "$@"; fi; }

# --- Git helpers -------------------------------------------------------------
git_repo_ok() { # dir, remote-substring, label
  local dir="$1" match="$2" label="$3"
  [ -d "$dir/.git" ] || die "$label: '$dir' is not a git repo"
  local url; url="$(git -C "$dir" remote get-url origin 2>/dev/null || true)"
  [[ "$url" == *"$match"* ]] || die "$label: origin ('$url') does not look like $match"
  local br; br="$(git -C "$dir" rev-parse --abbrev-ref HEAD)"
  [ "$br" = "main" ] || warn "$label: on branch '$br' (expected main)"
}

commit_and_push() { # dir, label, deploy-url
  local dir="$1" label="$2" url="$3"
  local n; n="$(git -C "$dir" status --porcelain | wc -l | tr -d ' ')"
  if [ "$n" -eq 0 ]; then
    ok "$label: nothing to commit (already up to date)"
  else
    log "$label: committing $n changed file(s)"
    run "git -C '$dir' add -A"
    run "git -C '$dir' commit -q -m \"$MSG\""
  fi
  local pushflag=""; $FORCE && pushflag="--force-with-lease"
  log "$label: pushing to origin main $pushflag"
  if $DRY_RUN; then
    printf "  [dry-run] git -C '%s' push %s origin main\n" "$dir" "$pushflag"
  elif git -C "$dir" push $pushflag origin main; then
    ok "$label: pushed → $url"
  else
    die "$label: push rejected. If the remote diverged, re-run with --force (uses --force-with-lease)."
  fi
}

# --- Preflight ---------------------------------------------------------------
log "Preflight"
[ -n "$PROD_DIR" ] && [ -d "$PROD_DIR" ] || die "Prod dir not found (set REUNIONS_PROD_DIR)"
git_repo_ok "$STAGING_DIR" "$STAGING_REMOTE_MATCH" "staging"
git_repo_ok "$PROD_DIR" "$PROD_REMOTE_MATCH" "prod"
$SKIP_BUILD || command -v ignite >/dev/null || die "ignite CLI not found in PATH"
ok "staging: $STAGING_DIR"
ok "prod:    $PROD_DIR"
$DRY_RUN && warn "DRY RUN — no commits, pushes, or file changes will be made"

# --- 1. Build ----------------------------------------------------------------
if ! $PROD_ONLY; then
  if $SKIP_BUILD; then
    warn "Skipping build (using existing docs/)"
  else
    log "Building site with Ignite → docs/"
    run "cd '$STAGING_DIR' && ignite build"
  fi
  [ -f "$STAGING_DIR/docs/index.html" ] || $DRY_RUN || die "Build produced no docs/index.html"
  # Sanity: staging docs must carry the STAGING CNAME, not prod's.
  if [ -f "$STAGING_DIR/docs/CNAME" ]; then
    grep -q "staging" "$STAGING_DIR/docs/CNAME" || warn "docs/CNAME is not the staging domain: $(cat "$STAGING_DIR/docs/CNAME")"
  fi
  ok "Build ready"

  # --- 2. Deploy staging -----------------------------------------------------
  log "Deploy → STAGING (ReunionsCode)"
  commit_and_push "$STAGING_DIR" "staging" "$STAGING_URL"
fi

if $STAGE_ONLY; then
  ok "Done (staging only)."; exit 0
fi

# --- 3. Confirm prod ---------------------------------------------------------
if ! $ASSUME_YES && ! $DRY_RUN; then
  printf "$(c '1;33')Deploy to PRODUCTION (%s)? [y/N] $(c 0)" "$PROD_URL"
  read -r reply
  [[ "$reply" =~ ^[Yy]$ ]] || die "Aborted before prod."
fi

# --- 4. Sync docs/ → prod ----------------------------------------------------
rsync_flags=( -a )
if $PRUNE; then
  warn "Sync mode: PRUNE — files absent from docs/ will be DELETED from prod"
  rsync_flags+=( --delete )
  # Force a dry-run preview of a prune even on a real run, so deletions are seen first.
  if ! $DRY_RUN; then
    log "Previewing deletions before pruning…"
    rsync -a --delete -n -v "${RSYNC_EXCLUDES[@]}" "$STAGING_DIR/docs/" "$PROD_DIR/" | grep '^deleting ' || echo "  (nothing to delete)"
    if ! $ASSUME_YES; then
      printf "$(c '1;33')Proceed with the deletions above? [y/N] $(c 0)"
      read -r reply; [[ "$reply" =~ ^[Yy]$ ]] || die "Aborted before prune."
    fi
  fi
else
  log "Syncing docs/ → prod (additive; keeping prod CNAME & .git)"
fi
$DRY_RUN && rsync_flags+=( -n -v )
rsync "${rsync_flags[@]}" "${RSYNC_EXCLUDES[@]}" "$STAGING_DIR/docs/" "$PROD_DIR/"
# Guard: prod CNAME must still be the production domain after sync.
if [ -f "$PROD_DIR/CNAME" ]; then
  grep -q "reunions" "$PROD_DIR/CNAME" || die "prod CNAME changed unexpectedly: $(cat "$PROD_DIR/CNAME")"
  ok "prod CNAME intact: $(cat "$PROD_DIR/CNAME")"
else
  warn "prod has no CNAME file"
fi

# --- 5. Deploy prod ----------------------------------------------------------
log "Deploy → PROD (reunions2025)"
commit_and_push "$PROD_DIR" "prod" "$PROD_URL"

ok "All done."
printf "   staging: %s\n   prod:    %s\n" "$STAGING_URL" "$PROD_URL"
