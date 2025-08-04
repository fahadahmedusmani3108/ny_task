//
//  Untitled.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import XCTest
import Combine
@testable import NY_Task

class ArticleListViewModelTests: XCTestCase {
    var viewModel: ArticleListViewModel!
    var mockRepository: MockArticleRepository!
    var mockCoordinator: MockCoordinator!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockArticleRepository()
        mockCoordinator = MockCoordinator()
        viewModel = ArticleListViewModel(repository: mockRepository, coordinator: mockCoordinator)
        cancellables = []
    }
    
    func test_screenTitle_returnsCorrectLocalizedString() {
        XCTAssertEqual(viewModel.screenTitle, "NY Times Most Popular")
    }
    
    func testSuccessfulArticleLoading() async {
        // Given
        mockRepository.scenario = .success
        
        // When
        let expectation = XCTestExpectation(description: "Articles loaded")
        var receivedArticles: [ArticleListItem] = []
        
        viewModel.showArticlePublisher
            .dropFirst()
            .sink {
                receivedArticles = $0
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadUI()
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedArticles.count, 1)
        XCTAssertEqual(receivedArticles[0].title, "Why Women Are Weary")
    }
    
    func testEmptyArticleState() async {
        // Given
        mockRepository.scenario = .empty
        
        // When/Then
        let expectation = XCTestExpectation(description: "Empty state")
        
        viewModel.showArticlePublisher
            .dropFirst()
            .sink {
                XCTAssert($0.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadUI()
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testArticleErrorHandling() async {
        // Given
        mockRepository.scenario = .failure(NetworkError.invalidResponse)
        
        // When/Then
        let expectation = XCTestExpectation(description: "Error received")
        
        viewModel.errorPublisher
            .sink {
                XCTAssertNotNil($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadUI()
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testArticleSelectionSuccess() throws {
        // Given
        mockRepository.scenario = .success
        let testIndex = 0 // Select first article
        
        // When
        viewModel.loadUI() // Load data first
        viewModel.didSelectRowAt(at: testIndex)
        
        // Then
        XCTAssertTrue(mockCoordinator.navigateToDetailCalled, "Coordinator should be triggered")
        XCTAssertEqual(mockCoordinator.lastSelectedArticle?.title, "Why Women Are Weary", "Should pass correct article")
    }
    
    func testArticleSelectionFailure() async {
        // Given
        mockRepository.scenario = .success
        let testIndex = 1 // Select invalid article index
        
        // When
        let expectation = XCTestExpectation(description: "Error received")
        
        viewModel.errorPublisher
            .sink {
                XCTAssertNotNil($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadUI()
        viewModel.didSelectRowAt(at: testIndex)
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertFalse(mockCoordinator.navigateToDetailCalled, "Coordinator should not be triggered")
    }
}
