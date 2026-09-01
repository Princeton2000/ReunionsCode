# Handoff — Princeton 2000 Reunions Site

**Last session:** 2026-08-27 · **Written:** 2026-08-31
**State:** Shipped to production. Both repos clean and in sync with their remotes.

---

## Where things stand

The site was rolled forward to the **27th Reunion, May 20–23, 2027** and deployed to
production. Staging and production are byte-identical.

| Repo | HEAD | Remote |
|---|---|---|
| Staging — `Princeton2000/ReunionsCode` | `f257ec034` | in sync |
| Prod — `Princeton2000/reunions2025` | `89128c7e` | in sync |

Live and verified on <https://reunions.princeton2000.org>: nav reads "Reunions 2025",
reunion banner correctly absent, 25 library spacers present, JSON-LD start
`2027-05-20T16:00:00Z`, CNAME intact.

---

## Do these first

Two stray-file issues exist right now. Both stem from `deploy.sh` running `git add -A`,
which is indiscriminate.

1. **`.build/` is sitting untracked in the production repo** (264K, 66 files), and that
   repo has **no `.gitignore`**. The prod repo root *is* the published site root, so the
   next `./deploy.sh` would commit and publish all 66 files to
   `reunions.princeton2000.org`. Fix before any deploy:

   ```sh
   printf '.build/\n.DS_Store\n' > ~/Dropbox/Computer/Development/Swift/reunions2025/.gitignore
   ```

2. **`Resources/.#library.json` is deleted-but-uncommitted on staging.** It's an Emacs
   lock file that `git add -A` swept into commit `b7aff0ebb`. Deleting it is correct —
   just commit the deletion. Consider adding `.#*` to the staging `.gitignore`.

Related: `latest.json` was removed from the prod repo during the last deploy and preserved
at the session scratchpad path. It is regenerable quality-gate output; nothing to restore.

---

## The main change: one source of truth for reunion dates

`Sources/Helpers/Reunion.swift` now holds `Reunion.upcoming`. **Edit that and nothing
else** to roll the site to a new reunion. Everything derives from it: `title`,
`yearLabel`, `dayRange`, `dateRange`, `longDateRange`, `eventName`, `startISO8601` /
`endISO8601`, `callToAction`, `registrationLink`, `showsBanner`.

Consumers: `Site.swift`, `MainLayout` (JSON-LD + banner), `Home` (description, About
prose), `ClassHome` (banner).

### Current settings

- Reunion **May 20–23, 2027**, ordinal 27
- `announcementBegins` **2027-03-01** — banner appears
- `registrationOpens` **2027-04-15** — "Register Now!" and the live link appear

Banner states, all date-driven, nothing to flip by hand:
hidden → announce (plain text) → register (linked) → hidden after the end date.

### Why it exists

`MainLayout`'s banner is gated on the reunion end date. After the 2025 reunion passed the
banner went dormant, so **its copy stopped being maintained because nobody could see it.**
Rolling dates to 2027 flipped the gate back on and instantly republished *"Reunions is May
22-25, 2025 – Register Now!"* with a dead 2025 URL across **137 pages**. A dormant call
site drifts silently from a live one — hence deriving everything from one value.

**Verify a rollover by building it**, not by reading it. Temporarily set awkward values
(month-spanning dates, an ordinal ending in 1) and grep `docs/`. That's what caught that
ordinals must render "31st", not "31th".

---

## Deliberately NOT derived

`NavBar.swift` has a literal `Dropdown("Reunions 2025")`. **This is correct.** That menu
points at Registration, Housing, Schedule, Kids, Jacket, Service — all still *25th
Reunion* content. The label describes what's behind the menu, not the upcoming reunion.
It was briefly wired to `Reunion.upcoming.yearLabel` and that was wrong.

By the same logic these are **not** stale and need no action until that content itself
rolls over to 2027:

- the Service link's `letherplay.org/princeton-reunions-2025` URL
- `CommitteeAG` / `CommitteeReunions` page titles ("2025 …")
- `Registration.swift:71-72` registration windows (2025 dates)
- `Content/faq/*.md` entries describing the 25th Reunion (one has a `golfcart25` link)

`Content/letters/*` are dated historical correspondence — **never** update dates in them.

---

## Also changed last session

- **Ignite repinned.** The fork's `feature/structured-data` branch had been force-pushed,
  orphaning the pinned commit; the build was broken before the session started. Now at
  `b246677d`.
- **`@MainActor` removed from 11 helpers.** Ignite commit `edc913e2` adopted Sendable and
  dropped MainActor isolation from rendering types, breaking 8 call sites. The helpers are
  pure HTML builders, so removing the annotation is the correct direction.
- **Timezone bug fixed.** `TimeZone(abbreviation: "EST")` is a fixed −5 offset; Reunions is
  in May (EDT, −4), so structured-data timestamps were an hour off. Now
  `America/New_York`.
- **Two end times reconciled.** `MainLayout` said the reunion ended at 2:00 AM, `Home`
  said 10:00 AM. Consolidated on 10:00 AM — this also controls when the banner disappears.
- **Duplicate banner removed.** `MainLayout` wraps every page and already renders the
  banner; `Home` had its own copy, stacking two on the homepage. `ClassHome` keeps its own
  because `EmbedLayout` has no banner.
- **Library spacing fixed.** Bare `Spacer()` emits `<div class="mt-auto">`, which collapses
  to zero height outside a flex container, so the last entry per classmate sat flush against
  the next header. Now `Spacer(size: 20)`. 25 entries affected.
- **Dead `?? Date.distantPast`** removed in `Home.swift` (`lastModified` is non-optional now).

Build is **0 errors / 0 warnings**.

---

## Open questions for the user

- **Is April 15, 2027 the real registration open date?** It's currently a date-driven
  switch, so the live "Register Now!" link turns itself on that day. If it's wrong, a
  link goes live pointing at a page that isn't.
- **Banner wording** — "registration opens soon" is a placeholder. A named month is a
  one-line change.
- **Staging is crawlable.** `deployment()` returns `.production` unconditionally, so the
  staging build emits production URLs in `sitemap.xml`, `feed.rss`, `og:url`, and
  `robots.txt` — while `robots.txt` says `Allow: /`. Harmless for review and it's what
  makes the two hosts byte-identical, but worth a decision if duplicate indexing matters.
  Fix would be a staging-specific `robots.txt`, *not* changing `deployment()`.
- **No `.nojekyll`.** GitHub Pages runs Jekyll, which silently drops paths beginning with
  `_`. Zero such paths today, so nothing is broken — `Assets/.nojekyll` would close it off.

---

## Resuming

```sh
cd ~/Dropbox/Computer/Development/Swift/Princeton/Website/ExampleSite
ignite build                 # confirm 0/0 first
./deploy.sh --dry-run        # preview
./deploy.sh --stage-only     # push staging, review
./deploy.sh --prod-only -y   # then production
```

**Verify against the live URL, not the push.** GitHub Pages lags a minute or more and
edges update unevenly. Pick a propagation marker that cannot collide — watching for
`height: 20px` also matched a pre-existing `max-height: 20px` and falsely reported
success. Byte-comparing is unambiguous:

```sh
curl -s URL | wc -c        # vs   wc -c < docs/path/index.html
```

### Deeper references

- **Vault:** `projects/princeton2000/website-edit-and-deploy.md` — full trap list.
- **Artifact:** *Two Domains, One Build* — how one Ignite build reaches two GitHub Pages
  domains and every divergence from stock Ignite.
  <https://claude.ai/code/artifact/46b358a6-f75e-40e7-b406-ebf1ec16b72a>
