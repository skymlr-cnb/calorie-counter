import Foundation

public struct CalorieEntry: Identifiable, Equatable, Sendable {
  public let id: UUID
  public let item: FoodItem
  public let grams: Int

  public init(id: UUID = UUID(), item: FoodItem, grams: Int) {
    self.id = id
    self.item = item
    self.grams = grams
  }

  public var calories: Int {
    (item.caloriesPer100g * grams) / 100
  }
}
