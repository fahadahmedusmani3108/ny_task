//
//  ArticleNetworkService.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

/// Responsible for fetching articles from the network.
final class ArticleNetworkService: ArticleNetworkServiceProtocol, RequestBuilder {
    
    /// The API client used to send requests.
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }

    /// Fetches articles from the network based on the specified section and period.
    func fetchArticles(section: String,
                              period: String,
                              apiKey: String) async throws -> [Article] {
        let request = try buildRequest(
            endpointKey: APIConstants.EndpointKeys.mostPopular,
            customemHeaders: [:],
            pathParams: [APIConstants.PathComponent.section: section,
                         APIConstants.PathComponent.period: period],
            queryParams: [APIConstants.Query.apiKey: apiKey],
            body: nil as String?
        )
        let response: GetArticleResponse = try await client.send(request)
        return response.results ?? []
    }
}
