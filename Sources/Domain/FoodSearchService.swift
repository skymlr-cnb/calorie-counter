import Foundation

public protocol FoodSearchService: Sendable {
  func search(query: String) async throws -> [FoodItem]
}
