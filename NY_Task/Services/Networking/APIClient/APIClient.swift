//
//  APIClient.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//
import Foundation

final class APIClient: APIClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    /// Sends a network request and decodes the response into the specified type.
    func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            /// Check if the status code is in the range of 200 to 204 (successful responses).
            guard (200..<204).contains(httpResponse.statusCode) else {
                throw NetworkError.statusCode(httpResponse.statusCode)
            }
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        } catch {
            throw NetworkError.underlyingError(error)
        }
    }
}
