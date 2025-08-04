//
//  ArticleNetworkServiceProtocol.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

/// represents the network service protocol for fetching articles
/// it defines a method to fetch articles based on section and period
protocol ArticleNetworkServiceProtocol {
    func fetchArticles(section: String, period: String, apiKey: String) async throws -> [Article]
}
