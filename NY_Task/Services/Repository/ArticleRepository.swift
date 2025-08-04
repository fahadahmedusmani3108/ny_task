//
//  ArticleRepository.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

/// This repository interacts with the network service to fetch articles
/// and provides methods to retrieve articles in a specific format.
class ArticleRepository: ArticleRepositoryProtocol {
    private let networkService: ArticleNetworkServiceProtocol
    private var articles: [Article] = []
    
    init(networkService: ArticleNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    /// Fetches popular articles based on the specified section and period.
    /// - Returns: An array of `ArticleListItem` representing the fetched articles.
    func getPopularArticles(section: String, period: String, apiKey: String) async throws -> [ArticleListItem] {
        articles = try await networkService.fetchArticles(section: section,
                                                          period: period,
                                                          apiKey: apiKey)
        return mapToArticleListItem(from: articles)
    }
    
    /// Retrieves an article at the specified index.
    func getArticle(at index: Int) throws -> Article {
        guard articles.count > 0,
              articles.indices.contains(index) else {
            throw NetworkError.invalidResponse
        }
        return articles[index]
    }
}

private extension ArticleRepository {
    /// Maps an array of `Article` to an array of `ArticleListItem`.
    func mapToArticleListItem(from articles: [Article]) -> [ArticleListItem] {
        return articles.map { article in
            ArticleListItem(
                title: article.title,
                subtitle: article.byline,
                date: article.updated?.formatted(),
                image: #imageLiteral(resourceName: "article_image")
            )
        }
    }
}
