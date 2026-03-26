//
//  BaseApiClient.swift
//
//
//  Created by Miguel Solans on 21/05/2024.
//

import Foundation

/// HTTP verb methods
public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
    var method: String {
        return self.rawValue
    }
}

/// ApiClient errors
public enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case noData
    case decodingError(Error)
}


/// Base class for a ApiClient request
open class BaseApiClient {
    private let urlSession: URLSession
    private var baseURL: String
    private let configuration: ApiClientConfiguration

    public init(baseURL: String, configuration: ApiClientConfiguration, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.configuration = configuration
        self.urlSession = session
    }

    public func request<T: Decodable>(endpoint: String,
                                      method: HttpMethod,
                                      parameters: [String: Any]? = nil) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw ApiError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.method
        request.allHTTPHeaderFields = configuration.getHeaders()

        if let parameters = parameters, method != .get {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }

        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw ApiError.invalidStatusCode(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw ApiError.decodingError(error)
        }
    }
}
