//
//  EventType.swift
//  Princeton2000
//
//  Event type enum and icons
//

import Foundation

enum EventType: String, Codable {
    case registration = "Registration"
    case featureEvent = "Featured Event"
    case classAlumni = "Class Alumni"
    case classFamily = "Class Alumni, Friends, & Families"
    case universityAlumni = "University Alumni"
    case virtualEvent = "Virtual Event"
    case entertainment = "Entertainment"
    case lectureSeminar = "Lecture/Seminar"
    case forum = "Alumni-Faculty Forum"
    case communityService = "Community Service"
    case foodDrink = "Food & Drink"
    case movie = "Movie"
    case childrensActivity = "Children's Activity"
}

typealias EventIcon = (EventType, String, String)

let icons: [EventIcon] = [
    (.registration, "feather", "📝"),
    (.featureEvent, "people-fill", "🎪"),
    (.classAlumni, "person", "🐅"),
    (.classFamily, "people", "👯‍♂️"),
    (.universityAlumni, "person-walking", "🚶‍♀️"),
    (.virtualEvent, "laptop", "👩🏽‍💻"),
    (.entertainment, "music-note-beamed", "💃🕺"),
    (.lectureSeminar, "chat-dots", "🧑‍🏫"),
    (.forum, "wechat", "🧑‍🎓"),
    (.communityService, "person-raised-hand", "🤲"),
    (.foodDrink, "cup-straw", "🧇"),
    (.movie, "camera-reels", "📽️"),
    (.childrensActivity, "scooter", "🐯"),
]

func eventTypeIcon(_ type: EventType) -> (String, String) {
    (icons.first(where: { $0.0 == type })!.1, icons.first(where: { $0.0 == type })!.2)
}
