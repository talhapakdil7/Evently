//
//  DefaultEventService.swift
//  Evently
//
//  Created by Talha Pakdil on 24.04.2026.
//

import Foundation
final class DefaultEventService: EventService {
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "TICKETMASTER_API_KEY") as? String else {
            fatalError("API Key bulunamadı")
        }
        return key
    }
    
    func fetchEvents(latitude: Double, longitude: Double) async throws -> [Event] {
        
        let urlString = """
        https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(apiKey)&latlong=\(latitude),\(longitude)&radius=50&unit=km&size=100&sort=distance,asc
        """
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let http = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            print("Status Code:", http.statusCode)
            print(String(data: data, encoding: .utf8) ?? "No data")
            
            guard 200...299 ~= http.statusCode else {
                throw APIError.invalidResponse
            }
            
            do {
                let decoded = try JSONDecoder().decode(EventResponse.self, from: data)
                return decoded.embedded?.events ?? []
            } catch {
                throw APIError.decoding(error)
            }
            
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.network(error)
        }
    }
}
