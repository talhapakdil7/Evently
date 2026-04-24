//
//  APIError.swift
//  Evently
//
//  Created by Talha Pakdil on 24.04.2026.
//

import Foundation


enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case network(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .invalidResponse:
            return "Sunucudan geçersiz response"
        case .decoding:
            return "Veri parse edilemedi"
        case .network:
            return "İnternet hatası"
        }
    }
}
