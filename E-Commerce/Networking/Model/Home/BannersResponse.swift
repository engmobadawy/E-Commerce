//
//  BannersResponse.swift
//  E-CommerceAppLoginPage
//
//  Created by MohamedBadawi on 19/08/2025.
//


import Foundation

struct BannerResponse: Codable {
    let status: Bool
    let message: String
    let data: [Banner]
    let count: Int
}

struct Banner: Codable {
    let id: Int
    let createdAt: String
    let bannerImage: String
    let order: Int
    let offerID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case bannerImage = "banner_image"
        case order
        case offerID = "offer_id"
    }
}
