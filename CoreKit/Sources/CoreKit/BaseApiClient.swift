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
class BaseApiClient {
    private let urlSession: URLSession;
    
    private var baseURL: String;
    
    private let configuration: ApiClientConfiguration
    
    
    public init(baseURL: String, configuration: ApiClientConfiguration, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.configuration = configuration
        self.urlSession = session
    }
    
    
    public func request<T: Decodable>(endpoint: String,
                                      method: HttpMethod,
                                      parameters: [String: Any]? = nil,
                                      completion: @escaping (Result<T, ApiError>) -> Void) {
        
        // Construct the full URL
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create the URL request
        var request = URLRequest(url: url)
        request.httpMethod = method.method
        request.allHTTPHeaderFields = configuration.getHeaders()
        
        // Add parameters to the request body for non-GET requests
        if let parameters = parameters, method != .get {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completion(.failure(.decodingError(error)))
                return
            }
        }
        
        // Execute the request
        urlSession.dataTask(with: request) { data, response, error in
            // Ensure completion runs on the main thread
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.decodingError(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
    
    /// Set base API URL
    /// - Parameter baseURL: String API base URL
    public func setBaseURL(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
}
