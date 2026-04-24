//
//  EventService.swift
//  Evently
//
//  Created by Talha Pakdil on 24.04.2026.
//

import Foundation


protocol EventService {
    func fetchEvents(latitude: Double, longitude: Double) async throws -> [Event]
}
