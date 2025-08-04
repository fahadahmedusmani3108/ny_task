//
//  TestArticleProvider.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

@testable import NY_Task

struct TestArticleProvider {
    static func createMockArticle() -> Article? {
        do {
            let response: GetArticleResponse = try JSONLoader.load("article_list")
            return response.results?.first
        } catch {
            return nil
        }
    }
}
