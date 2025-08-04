//
//  MockArticleDetailViewModel.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//
import Combine
@testable import NY_Task

class MockArticleDetailViewModel: ArticleDetailViewModelAdaptable {
    var screenTitle: String = "NY Times Most Popular"
    var showDetailPublisher = PassthroughSubject<Article, Never>()
    var didSubscribeToPublisher = false
    
    func loadUI() {}
    
    func simulateShowArticleDetail(_ article: Article) {
        showDetailPublisher.send(article)
    }
}
