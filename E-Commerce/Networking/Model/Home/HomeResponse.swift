//
//  HomeResponse.swift
//  E-CommerceAppLoginPage
//
//  Created by MohamedBadawi on 19/08/2025.
//


//
//  HomeResponse.swift
//

import Foundation

// MARK: - Home Response
struct HomeResponse: Codable {
    let status: Bool
    let message: String
    let data: HomeData
}

// MARK: - Home Data
struct HomeData: Codable {
    let categories: [HomeCategory]
    let brands: [HomeBrand]
    let featured: [HomeFeatured]
}

// MARK: - Category
struct HomeCategory: Codable {
    let id: Int
    let name: String
    let image: String
}

// MARK: - Brand
struct HomeBrand: Codable {
    let id: Int
    let name: String
    let image: String
}

// MARK: - Featured Product
struct HomeFeatured: Codable {
    let id: Int
    let image: String
    let name: String
    let subCategoryId: Int
    let brandName: String
    let requiresPrescription: Int
    let price: String
    let tax: Int
    let offerId: Int?
    let offerTitle: String
    let offerPrice: String
    let isFavorite: Int
    let isCart: Int
    let rateAvg: String
    let rateCount: Int

    enum CodingKeys: String, CodingKey {
        case id, image, name, price, tax
        case subCategoryId = "sub_category_id"
        case brandName = "brand_name"
        case requiresPrescription = "requires_prescription"
        case offerId = "offer_id"
        case offerTitle = "offer_title"
        case offerPrice = "offer_price"
        case isFavorite = "is_favorite"
        case isCart = "is_cart"
        case rateAvg = "rate_avg"
        case rateCount = "rate_count"
    }
}
