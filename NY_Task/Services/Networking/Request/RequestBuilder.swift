//
//  RequestBuilderProtocol.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//
import Foundation

/// Protocol for building network requests
protocol RequestBuilder {
    func buildRequest<T: Encodable>(
            endpointKey: String,
            customemHeaders: [String: String],
            pathParams: [String: String],
            queryParams: [String: String],
            body: T?
        ) throws -> URLRequest
}

extension RequestBuilder {
    /// Builds a URLRequest based on the provided parameters.
    func buildRequest<T: Encodable>(
        endpointKey: String,
        customemHeaders: [String: String] = [:],
        pathParams: [String: String] = [:],
        queryParams: [String: String] = [:],
        body: T? = nil
    ) throws -> URLRequest {
        /// 1. Resolve base URL and endpoint configuration
        let baseURL = try EndpointProvider.baseURL()
        let config = try EndpointProvider.endpointConfig(for: endpointKey)
        let path = config.path
        let resolvedPath = pathParams.reduce(path) { path, param in
            path.replacingOccurrences(of: "{\(param.key)}", with: param.value)
        }
        
        /// 2. Create URLComponents with base URL and resolved path
        guard var components = URLComponents(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        components.path = resolvedPath
        
        /// 3. Add query parameters if any
        let allQueryParams = queryParams
        components.queryItems = allQueryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        /// If URLComponents fails to create a valid URL, throw an error
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        /// 4. Create URLRequest with the constructed URL
        var request = URLRequest(url: url)
        request.httpMethod = config.method.rawValue
        
        /// 5. Set the request body if provided and method is not GET
        if let body = body,
           config.method != .get {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        /// 6. Set common headers
        request.setValue(APIConstants.Header.Value.json, forHTTPHeaderField: APIConstants.Header.accept)
        
        /// 7. Set custom headers if provided
        for (key, value) in customemHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
    
        return request
    }
}
