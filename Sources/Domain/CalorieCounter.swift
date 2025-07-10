import Foundation

public actor CalorieCounter {
  private var entries: [CalorieEntry] = []

  public init() {}

  @discardableResult
  public func add(item: FoodItem) -> CalorieEntry {
    let entry = CalorieEntry(item: item, grams: 100)
    entries.append(entry)
    return entry
  }

  public func totalCalories() -> Int {
    entries.reduce(0) { $0 + $1.calories }
  }
}
