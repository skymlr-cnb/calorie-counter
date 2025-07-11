import Domain
import XCTest

@testable import Data

final class LLMFoodSearchRepositoryTests: XCTestCase {
  func testSearchParsesItems() async throws {
    let response = "{" + "\"items\":[{\"name\":\"Apple\",\"caloriesPer100g\":52},{\"name\":\"Banana\",\"caloriesPer100g\":89}]}"
    let client = MockLLMClient(response: response)
    let repo = LLMFoodSearchRepository(client: client)
    let items = try await repo.search(query: "fruit")
    XCTAssertEqual(items.count, 2)
    XCTAssertEqual(items[0].name, "Apple")
    XCTAssertEqual(items[0].caloriesPer100g, 52)
    XCTAssertEqual(items[1].name, "Banana")
    XCTAssertEqual(items[1].caloriesPer100g, 89)
  }
}

private struct MockLLMClient: LLMClient {
  let response: String
  func send(prompt: String) async throws -> String { response }
}
