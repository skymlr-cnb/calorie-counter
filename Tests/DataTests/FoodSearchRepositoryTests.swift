import Domain
import XCTest

@testable import Data

final class FoodSearchRepositoryTests: XCTestCase {
  func testSearchParsesItems() async throws {
    let url = Bundle.module.url(
      forResource: "search", withExtension: "json", subdirectory: "Fixtures")!
    let data = try Data(contentsOf: url)
    let client = MockClient(data: data)
    let repo = FoodSearchRepository(client: client)
    let results = try await repo.search(query: "fruit")
    XCTAssertEqual(results.count, 2)
    XCTAssertEqual(results[0].name, "Apple")
    XCTAssertEqual(results[0].caloriesPer100g, 52)
    XCTAssertEqual(results[1].caloriesPer100g, 89)
  }
}

private struct MockClient: APIClient {
  let data: Data
  func get(url: URL) async throws -> Data { data }
}
