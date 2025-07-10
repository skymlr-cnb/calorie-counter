import Foundation

struct SearchResponseDTO: Decodable {
  let products: [ProductDTO]
}

struct ProductDTO: Decodable {
  let id: String
  let productName: String?
  let nutriments: NutrimentsDTO?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case productName = "product_name"
    case nutriments
  }
}

struct NutrimentsDTO: Decodable {
  let energyKcal100g: Double?
  let energyKcalServing: Double?

  enum CodingKeys: String, CodingKey {
    case energyKcal100g = "energy-kcal_100g"
    case energyKcalServing = "energy-kcal_serving"
  }
}
