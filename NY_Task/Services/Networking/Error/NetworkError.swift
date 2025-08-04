//
//  NetworkError.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//
import Foundation

/// This enum defines various network-related errors that can occur during API requests.
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case statusCode(Int)
    case decodingFailed(Error)
    case underlyingError(Error)
    case indexOutOfBounds
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return ArticleUIString.invalidUrl.localized
        case .requestFailed(let error): return ArticleUIString.requestFailed.localized(with: error.localizedDescription)
        case .invalidResponse: return ArticleUIString.invalidResponse.localized
        case .statusCode(let code): return ArticleUIString.statusCode.localized(with: code)
        case .decodingFailed(let error): return ArticleUIString.decodingFailed.localized(with: error.localizedDescription)
        case .underlyingError(let error):
            return ArticleUIString.unExpectedError.localized(with: error.localizedDescription)
        case .indexOutOfBounds:
            return ArticleUIString.indexOutOfBounds.localized
        }
    }
}
