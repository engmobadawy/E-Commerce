//
//  LoginResponse.swift
//  E-CommerceAppLoginPage
//
//  Created by MohamedBadawi on 19/08/2025.
//


//
//  LoginResponse.swift
//

import Foundation

// MARK: - Login Response
struct LoginResponse: Codable {
    let status: Bool
    let message: String
    let data: LoginData
    let token: String
}

// MARK: - Login Data
struct LoginData: Codable {
    let name: String
    let email: String
    let phone: String
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case profileImage = "profile_image"
    }
}
