import Foundation

struct Menu: Codable {
    let categoryID: [Int]
    let description: String
    let image: String
    let name: String
    let cost: Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case image, name, description, cost
    }
}
