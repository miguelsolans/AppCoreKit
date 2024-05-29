//
//  ApiClientConfiguration.swift
//
//
//  Created by Miguel Solans on 21/05/2024.
//

import Foundation

public class ApiClientConfiguration {
    private var headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    public init() {}
    
    /// Get request headers
    /// - Returns: Dictionary of headers
    public func getHeaders() -> [String: String] {
        return headers
    }
    
    /// Set request headers
    /// - Parameter newHeaders: Dictionary of headers
    public func setHeaders(_ newHeaders: [String: String]) {
        self.headers = newHeaders
    }
    
    /// Add a single header to request
    /// - Parameters:
    ///   - key: Header name
    ///   - value: Header value
    public func addHeader(key: String, value: String) {
        self.headers[key] = value
    }
    
    /// Remove a header by its name
    /// - Parameter key: Header name
    public func removeHeader(key: String) {
        self.headers.removeValue(forKey: key)
    }
}
