import Domain
import Foundation

public struct FoodSearchRepository: FoodSearchService, Sendable {
  private let client: APIClient
  private let jsonDecoder: JSONDecoder

  public init(client: APIClient = URLSessionAPIClient()) {
    self.client = client
    self.jsonDecoder = JSONDecoder()
  }

  public func search(query: String) async throws -> [FoodItem] {
    let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let urlString =
      "https://world.openfoodfacts.org/api/v2/search?categories_tags_en=food&search_terms=\(encoded)&fields=code,product_name,product_name_en,generic_name_en,nutriments&page_size=20"
    guard let url = URL(string: urlString) else { return [] }
    let data = try await client.get(url: url)
    let dto = try jsonDecoder.decode(SearchResponseDTO.self, from: data)
    return dto.products.compactMap { product in
      guard let nutriments = product.nutriments else { return nil }
      let name = product.genericNameEn ?? product.productNameEn ?? product.productName
      guard let cleanName = name?.trimmingCharacters(in: .whitespacesAndNewlines), !cleanName.isEmpty else { return nil }
      let calories = Int(nutriments.energyKcal100g ?? nutriments.energyKcalServing ?? 0)
      return FoodItem(id: product.id, name: cleanName, caloriesPer100g: calories)
    }
  }
}
