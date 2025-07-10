import Foundation

public struct FoodItem: Identifiable, Equatable, Codable, Sendable {
  public let id: String
  public let name: String
  public let caloriesPer100g: Int

  public init(id: String, name: String, caloriesPer100g: Int) {
    self.id = id
    self.name = name
    self.caloriesPer100g = caloriesPer100g
  }
}
