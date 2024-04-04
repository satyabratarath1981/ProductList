//
//  ProductsModel.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import Foundation

struct Products: Codable {
    let products: [ProductsDetails]
    let total, skip, limit: Int
}

struct ProductsDetails: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}

