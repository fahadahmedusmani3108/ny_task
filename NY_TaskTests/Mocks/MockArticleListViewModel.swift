//
//  MockArticleListViewModel.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import Combine
@testable import NY_Task

class MockArticleListViewModel: ArticleListViewModelAdaptable {
    
    // MARK: - Mock Publishers
    private let _showArticlePublisher = PassthroughSubject<[ArticleListItem], Never>()
    private let _errorPublisher = PassthroughSubject<Error, Never>()
    private let _isLoadingPublisher = PassthroughSubject<Bool, Never>()
    
    // MARK: - Protocol Conformance
    var screenTitle: String = "Mock Articles"
    
    var showArticlePublisher: AnyPublisher<[ArticleListItem], Never> {
        _showArticlePublisher.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<Error, Never> {
        _errorPublisher.eraseToAnyPublisher()
    }
    
    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        _isLoadingPublisher.eraseToAnyPublisher()
    }
    
    // MARK: - Tracking Properties
    private(set) var loadUICalled = false
    private(set) var selectedIndex: Int?
    
    // MARK: - Test Control Methods
    func simulateArticles(_ articles: [ArticleListItem]) {
        _showArticlePublisher.send(articles)
    }
    
    func simulateError(_ error: Error) {
        _errorPublisher.send(error)
    }
    
    func simulateLoading(_ isLoading: Bool) {
        _isLoadingPublisher.send(isLoading)
    }
    
    // MARK: - Protocol Methods
    func loadUI() {
        loadUICalled = true
    }
    
    func didSelectRowAt(at index: Int) {
        selectedIndex = index
    }
}
