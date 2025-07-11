import Domain
import Foundation

public struct LLMFoodSearchRepository: FoodSearchService, Sendable {
  private let client: LLMClient
  private let jsonDecoder: JSONDecoder = JSONDecoder()

  public init(client: LLMClient) {
    self.client = client
  }

  public func search(query: String) async throws -> [FoodItem] {
    let prompt = """
    You are a nutrition assistant. When given a food search query, reply ONLY in JSON with an array called items. Each item must contain a name and caloriesPer100g integer. Example:\n{"items":[{"name":"Apple","caloriesPer100g":52}]}. If you are unsure of the calories, skip that food.
    Query: \(query)
    """

    let responseText = try await client.send(prompt: prompt)
    print("[LLMFoodSearchRepository] Raw response: \(responseText)")

    let data = Data(responseText.utf8)
    do {
      let result = try jsonDecoder.decode(LLMFoodResult.self, from: data)
      return result.items.enumerated().map { idx, element in
        FoodItem(id: "\(idx)-\(element.name)", name: element.name, caloriesPer100g: element.caloriesPer100g)
      }
    } catch {
      print("[LLMFoodSearchRepository] Failed to decode response: \(error)")
      throw error
    }
  }
}

private struct LLMFoodResult: Decodable {
  let items: [LLMFood]
}

private struct LLMFood: Decodable {
  let name: String
  let caloriesPer100g: Int
}
