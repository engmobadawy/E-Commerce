//
//  BannersResponse.swift
//  E-CommerceAppLoginPage
//
//  Created by MohamedBadawi on 19/08/2025.
//


//
//  BannersResponse.swift
//

import Foundation

// MARK: - Banners Response
struct BannersResponse: Codable {
    let status: Bool
    let message: String
    let data: [BannerItem]
    let count: Int
}

// MARK: - Banner Item
struct BannerItem: Codable {
    let id: Int
    let createdAt: String
    let bannerImage: String
    let order: Int
    let offerId: Int?

    enum CodingKeys: String, CodingKey {
        case id, order
        case createdAt = "created_at"
        case bannerImage = "banner_image"
        case offerId = "offer_id"
    }
}
