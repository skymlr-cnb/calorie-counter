import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public protocol APIClient: Sendable {
  func get(url: URL) async throws -> Data
}

public struct URLSessionAPIClient: APIClient, @unchecked Sendable {
  private let session: URLSession

  public init(session: URLSession = .shared) {
    self.session = session
  }

  public func get(url: URL) async throws -> Data {
    let (data, response) = try await session.data(from: url)
    guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
      throw URLError(.badServerResponse)
    }
    return data
  }
}
