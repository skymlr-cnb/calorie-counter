import Foundation

public protocol FoodSearchService {
  func search(query: String) async throws -> [FoodItem]
}
