
//
//  Created by MohamedBadawi on 19/08/2025.
//

//
//  NetworkManager.swift
//  E-CommerceAppLoginPage
//

import Foundation
import SwiftKeychainWrapper

// MARK: - Network Manager
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // Generic Request
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: [String: Any]? = nil,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: API.baseURL + endpoint) else {
            print("❌ Invalid URL: \(API.baseURL + endpoint)")
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Debug: Print request details
        print("🚀 REQUEST:")
        print("URL: \(url)")
        print("Method: \(method.rawValue)")
        
        // Attach token from Keychain
        if let token = KeychainWrapper.standard.string(forKey: "authToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print("🔐 Token: Bearer \(String(token.prefix(20)))...") // Show first 20 chars only
        } else {
            print("⚠️ No token found in Keychain")
        }
        
        // Encode body for POST/PUT
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            print("📤 Body: \(body)")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Debug: Print response details
            print("📥 RESPONSE:")
            
            // Network Error
            if let error = error {
                print("❌ Network Error: \(error.localizedDescription)")
                completion(.failure(.unknown(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ No HTTP Response")
                completion(.failure(.noData))
                return
            }
            
            print("📊 Status Code: \(httpResponse.statusCode)")
            
            // Print raw response data for debugging
            if let data = data {
                print("📄 Response Data Length: \(data.count) bytes")
                if let responseString = String(data: data, encoding: .utf8) {
                    print("📄 Raw Response: \(responseString)")
                }
            } else {
                print("❌ No response data received")
            }
            
            // Error status codes
            switch httpResponse.statusCode {
            case 200...299:
                print("✅ HTTP Success (\(httpResponse.statusCode))")
                break // OK
            case 401:
                print("❌ 401 Unauthorized - Token may be expired")
                completion(.failure(.unauthorized)); return
            case 403:
                print("❌ 403 Forbidden - No permission")
                completion(.failure(.forbidden)); return
            case 404:
                print("❌ 404 Not Found - Check endpoint")
                completion(.failure(.notFound)); return
            case 500...599:
                print("❌ Server Error (\(httpResponse.statusCode))")
                completion(.failure(.serverError)); return
            default:
                print("❌ Unexpected Status Code: \(httpResponse.statusCode)")
                // Try to decode backend error JSON
                if let data = data,
                   let serverError = try? JSONDecoder().decode(ServerErrorResponse.self, from: data),
                   let message = serverError.message {
                    completion(.failure(.custom(message: message)))
                } else {
                    completion(.failure(.custom(message: "Unexpected status code: \(httpResponse.statusCode)")))
                }
                return
            }
            
            // Data Validation
            guard let data = data else {
                print("❌ No response data")
                completion(.failure(.noData))
                return
            }
            
            guard !data.isEmpty else {
                print("❌ Empty response data")
                completion(.failure(.noData))
                return
            }
            
            // JSON Decoding
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                print("✅ Successfully decoded response")
                completion(.success(decoded))
            } catch {
                print("❌ JSON Decoding Error: \(error)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, _):
                        print("Missing key: \(key.stringValue)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for \(type) at path: \(context.codingPath)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for \(type) at path: \(context.codingPath)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        break
                    }
                }
                completion(.failure(.decodingFailed(error)))
            }
            
        }.resume()
    }

    
    // MARK: - Login Request
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        let body: [String: Any] = [
                "phone": username,    // ✅ Changed from "username" to "phone"
                "password": password
            ]
        
        request(endpoint: API.Endpoints.login, method: .post, body: body) { (result: Result<LoginResponse, APIError>) in
            switch result {
            case .success(let response):
                
                    KeychainWrapper.standard.set(response.token, forKey: "authToken")
                
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Logout
    func logout() {
        KeychainWrapper.standard.removeObject(forKey: "authToken")
    }
    
    // MARK: - Home Data Fetching
    func fetchHomeData(completion: @escaping (Result<HomeResponse, APIError>) -> Void) {
        request<HomeResponse>(
            endpoint: API.Endpoints.home,
            method: .get,
            body: nil,
            completion: completion
        )
    }

}
