//
//  ArticleRepositoryProtocol.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

/// represents the protocol for the Article Repository, which defines methods to fetch articles from a data source.
/// This protocol is designed to be implemented by a concrete repository class that handles data fetching logic, such as network requests or database queries.
/// It abstracts the data access layer, allowing the rest of the application to interact with articles without needing to know the details of how they are retrieved.
protocol ArticleRepositoryProtocol {
    func getPopularArticles(section: String, period: String, apiKey: String) async throws -> [ArticleListItem]
    func getArticle(at index: Int) throws -> Article
}
