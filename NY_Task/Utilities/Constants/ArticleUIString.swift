//
//  ArticleUIString.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//
import Foundation

/// This enum defines the UI strings used in the article feature of the application.
enum ArticleUIString: String {
    case articleListTitle = "article_list_title"
    case alert = "alert"
    case invalidUrl = "invalid_url"
    case networkTimeout = "timeout"
    case decodingFailed = "decoding_failed"
    case requestFailed = "request_failed"
    case invalidResponse = "invalid_response"
    case statusCode = "status_code"
    case unExpectedError = "unexpected_error"
    case indexOutOfBounds = "index_out_of_bounds"
}

extension ArticleUIString {
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments)
    }
}
