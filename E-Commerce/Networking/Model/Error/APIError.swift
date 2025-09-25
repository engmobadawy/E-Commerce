//
//  APIError.swift
//  E-CommerceAppLoginPage
//
//  Created by MohamedBadawi on 19/08/2025.
//
import Foundation

// MARK: - API Error Handling
enum APIError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed(Error)
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case custom(message: String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please check the endpoint."
        case .noData:
            return "No data received from server."
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized. Please login again."
        case .forbidden:
            return "You don’t have permission to access this resource."
        case .notFound:
            return "The requested resource was not found."
        case .serverError:
            return "Server error occurred. Please try again later."
        case .custom(let message):
            return message
        case .unknown(let error):
            return "Unexpected error: \(error.localizedDescription)"
        }
    }
}
