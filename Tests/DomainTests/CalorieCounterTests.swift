import XCTest

@testable import Domain

final class CalorieCounterTests: XCTestCase {
  func testAddAndTotal() async {
    let counter = CalorieCounter()
    let item = FoodItem(id: "1", name: "Apple", caloriesPer100g: 50)
    await counter.add(item: item)
    let total = await counter.totalCalories()
    XCTAssertEqual(total, 50)
  }
}
