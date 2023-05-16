import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable {
    let title: String
    let price: String
    let image: String
    let category: String
    let description: String
}
