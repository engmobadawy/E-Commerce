//
//  APIConfig.swift
//  MagdyTask
//
//  Created by AMNY on 21/08/2025.
//


import Foundation


struct APIConfig {
    static let baseURL =  "https://backend.outletplus.sa/api/"
}

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var methods: HTTPMethod { get }
    var task: TaskRequest { get }
    var headers: [String: String]? { get }
}

enum TaskRequest {
    case requestPlain
    case requestParameters(Parameters: [String: Any], encoding: ParameterEncoding)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ParameterEncoding {
    case inBodyEncoding
    case inURLEncoding
}
