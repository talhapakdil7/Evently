//
//  EventViewModel.swift
//  Evently
//
//  Created by Talha Pakdil on 24.04.2026.
//

import Foundation
import Observation

@Observable
final class EventViewModel {
    
    
    var events: [Event] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    //DIP
    private let service: EventService
    
    init(service: EventService = DefaultEventService()) {
        self.service = service
    }
    
    func fetchEvents(lat: Double, lon: Double) {
        isLoading = true
        errorMessage = nil
        
        
        //task olusturduk async context
        Task {
            do {
                let result = try await service.fetchEvents(
                    latitude: lat,
                    longitude: lon
                )
                
                self.events = result
                self.isLoading = false
                
            } catch let error as APIError {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                
            } catch {
                self.errorMessage = "Bilinmeyen hata"
                self.isLoading = false
            }
        }
    }
}
