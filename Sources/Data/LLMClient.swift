import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol LLMClient: Sendable {
  func send(prompt: String) async throws -> String
}

public struct URLLLMClient: LLMClient, @unchecked Sendable {
  private let url: URL
  private let session: URLSession
  private let headers: [String: String]

  public init(url: URL, headers: [String: String] = [:], session: URLSession = .shared) {
    self.url = url
    self.headers = headers
    self.session = session
  }

  public func send(prompt: String) async throws -> String {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try JSONEncoder().encode(["inputs": prompt])
    request.allHTTPHeaderFields = headers.merging(["Content-Type": "application/json"]) { $1 }

    let (data, response) = try await session.data(for: request)
    guard let http = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }
    if !(200..<300).contains(http.statusCode) {
      let body = String(data: data, encoding: .utf8) ?? ""
      print("[URLLLMClient] HTTP \(http.statusCode) error: \(body)")
      throw HTTPError(statusCode: http.statusCode, body: body)
    }

    guard let text = String(data: data, encoding: .utf8) else {
      throw URLError(.cannotDecodeContentData)
    }
    return text
  }
}

public struct HTTPError: LocalizedError {
  public let statusCode: Int
  public let body: String

  public var errorDescription: String? {
    "HTTP \(statusCode): \(body)"
  }
}
