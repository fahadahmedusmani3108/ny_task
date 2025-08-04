//
//  MockArticleRepository.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import Combine
@testable import NY_Task

class MockArticleRepository: ArticleRepositoryProtocol {
    
    // MARK: - Configuration
    enum MockScenario {
        case success
        case empty
        case failure(Error)
    }
    
    var scenario: MockScenario = .success
    
    // MARK: - Protocol Implementation
    func getPopularArticles(section: String, period: String, apiKey: String) async throws -> [ArticleListItem] {
        switch scenario {
        case .success:
            let response: GetArticleResponse = try JSONLoader.load("article_list")
            return response.results?.map {
                ArticleListItem(
                    title: $0.title,
                    subtitle: $0.byline,
                    date: $0.updated?.formatted(),
                    image: nil
                )
            } ?? []
            
        case .empty:
            return []
            
        case .failure(let error):
            throw error
        }
    }
    
    func getArticle(at index: Int) throws -> Article {
        let response: GetArticleResponse = try JSONLoader.load("article_list")
        guard let results = response.results,
              results.indices.contains(index) else {
            throw NetworkError.indexOutOfBounds
        }
        return results[index]
    }
}
