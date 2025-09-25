//
//  SlidersResponse.swift
//  E-CommerceAppLoginPage
//
//  Created by MohamedBadawi on 19/08/2025.
//


//
//  SlidersResponse.swift
//

import Foundation

// MARK: - Sliders Response
struct SlidersResponse: Codable {
    let status: Bool
    let message: String
    let data: [SliderItem]
    let count: Int
}

// MARK: - Slider Item
struct SliderItem: Codable {
    let id: Int
    let createdAt: String
    let sliderImage: String
    let order: Int
    let offerId: Int?

    enum CodingKeys: String, CodingKey {
        case id, order
        case createdAt = "created_at"
        case sliderImage = "slider_image"
        case offerId = "offer_id"
    }
}
