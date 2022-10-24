//
//  MenuModel.swift
//  Delivery
//
//  Created by Artsiom Korenko on 24.10.22.
//

import Foundation

struct Menu: Codable {
    let categoryID: [Int]
    let description: String
    let image: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case image, name, description
    }
}
