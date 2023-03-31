import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}


struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
    let description: String
    let image: String
}
