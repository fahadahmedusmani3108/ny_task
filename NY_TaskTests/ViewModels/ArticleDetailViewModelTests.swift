//
//  ArticleDetailViewModelTests.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import XCTest
import Combine
@testable import NY_Task

class ArticleDetailViewModelTests: XCTestCase {
    var viewModel: ArticleDetailViewModel!
    var mockArticle: Article!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockArticle = TestArticleProvider.createMockArticle()
        viewModel = ArticleDetailViewModel(selectedArticle: mockArticle)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockArticle = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_screenTitle_returnsCorrectLocalizedString() {
        XCTAssertEqual(viewModel.screenTitle, "NY Times Most Popular")
    }
    
    func test_loadUI_sendsArticleViaPublisher() {
        let expectation = self.expectation(description: "Publisher sends article")
        
        viewModel.showDetailPublisher
            .sink { article in
                XCTAssertEqual(article.title, self.mockArticle.title)
                XCTAssertEqual(article.abstract, self.mockArticle.abstract)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadUI()
        wait(for: [expectation], timeout: 1.0)
    }
}
