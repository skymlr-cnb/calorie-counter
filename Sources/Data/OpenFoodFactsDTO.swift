import Foundation

struct SearchResponseDTO: Decodable {
  let products: [ProductDTO]
}

struct ProductDTO: Decodable {
  let id: String
  let productName: String?
  let productNameEn: String?
  let genericNameEn: String?
  let nutriments: NutrimentsDTO?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case code
    case productName = "product_name"
    case productNameEn = "product_name_en"
    case genericNameEn = "generic_name_en"
    case nutriments
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let id = try container.decodeIfPresent(String.self, forKey: .id) ??
      container.decodeIfPresent(String.self, forKey: .code) {
      self.id = id
    } else {
      throw DecodingError.keyNotFound(
        CodingKeys.id,
        DecodingError.Context(
          codingPath: decoder.codingPath,
          debugDescription: "Missing product id"))
    }
    self.productName = try container.decodeIfPresent(String.self, forKey: .productName)
    self.productNameEn = try container.decodeIfPresent(String.self, forKey: .productNameEn)
    self.genericNameEn = try container.decodeIfPresent(String.self, forKey: .genericNameEn)
    self.nutriments = try container.decodeIfPresent(NutrimentsDTO.self, forKey: .nutriments)
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
