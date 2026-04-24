

import Foundation
import MapKit
import SwiftUI

struct EventResponse: Codable {
    let embedded: EventsContainer?
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct EventsContainer: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {
    let id: String
    let name: String
    let url: String?
    let images: [EventImage]?
    let dates: EventDates?
    let embedded: EventEmbedded?
    
    enum CodingKeys: String, CodingKey {
        case id, name, url, images, dates
        case embedded = "_embedded"
    }
}

struct EventImage: Codable {
    let url: String
}

struct EventDates: Codable {
    let start: EventStart?
}

struct EventStart: Codable {
    let localDate: String?
    let localTime: String?
}

struct EventEmbedded: Codable {
    let venues: [Venue]?
}

struct Venue: Codable { //mekanlar
    let name: String?
    let location: Location?
}

struct Location: Codable { //mekan konum
    let latitude: String?
    let longitude: String?
}

extension Event { // extension for event
    
    var imageURL: URL? {
        URL(string: images?.first?.url ?? "")
    }
    
    var venueName: String {
        embedded?.venues?.first?.name ?? "Unknown"
    }
    
    var coordinate: CLLocationCoordinate2D? { //Haritadaki bir noktanın enlem (latitude) ve boylam (longitude) bilgisini tutar.
        guard
            let lat = Double(embedded?.venues?.first?.location?.latitude ?? ""),
            let lon = Double(embedded?.venues?.first?.location?.longitude ?? "")
        else { return nil }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
extension Event {
    
    var iconName: String {
        let name = self.name.lowercased()
        
        // 🎵 MUSIC
        if containsAny(name, ["concert", "music", "live", "band", "dj", "tour"]) {
            return "music.mic"
        }
        
        // 🎉 FESTIVAL / PARTY
        if containsAny(name, ["festival", "party", "night", "show", "event"]) {
            return "party.popper"
        }
        
        // ⚽ SPORT
        if containsAny(name, ["sport", "match", "vs", "league", "football", "basketball"]) {
            return "sportscourt"
        }
        
        // 🎭 COMEDY / ART
        if containsAny(name, ["comedy", "theatre", "theater", "stand up", "show"]) {
            return "theatermasks"
        }
        
        // 💻 TECH
        if containsAny(name, ["tech", "conference", "summit", "developer", "ai"]) {
            return "desktopcomputer"
        }
        
        // 🎟️ DEFAULT
        return "ticket.fill"
    }
    
    var color: Color {
            let name = self.name.lowercased()
            
            // 🎵 MUSIC
            if containsAny(name, ["live", "concert", "music", "dj", "tour", "band"]) {
                return .purple
            }
            
            // 🎉 PARTY / FESTIVAL
            if containsAny(name, ["party", "festival", "night", "show"]) {
                return .orange
            }
            
            // ⚽ SPORT
            if containsAny(name, ["vs", "league", "match", "football", "basketball"]) {
                return .green
            }
            
            // 🎭 COMEDY / ART
            if containsAny(name, ["comedy", "stand", "theatre", "show"]) {
                return .pink
            }
            
            // 💻 TECH
            if containsAny(name, ["tech", "developer", "summit", "ai"]) {
                return .blue
            }
            
            return .red
        }
    
    // 🔥 Helper function (çok önemli)
    private func containsAny(_ text: String, _ keywords: [String]) -> Bool {
        keywords.contains { text.contains($0) }
    }
}
