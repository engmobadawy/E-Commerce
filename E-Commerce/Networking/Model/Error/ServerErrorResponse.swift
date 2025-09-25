//
//  ServerErrorResponse.swift
//  E-CommerceAppLoginPage
//
//  Created by MohamedBadawi on 19/08/2025.
//


// MARK:  we need the backend to make something genaric for any server

struct ServerErrorResponse: Codable {
    let status: Bool?
    let message: String?
}
