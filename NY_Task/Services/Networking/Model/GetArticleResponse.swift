//
//  GetArticleResponse.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

/// Represents the response from the NY Times API for fetching articles.
struct GetArticleResponse: Codable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    var results: [Article]?

    enum CodingKeys: String, CodingKey {
        case status, copyright, results
        case numResults = "num_results"
    }
}
