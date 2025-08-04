//
//  ArticleDetailViewControllerTests.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import XCTest
import Combine
@testable import NY_Task

class ArticleDetailViewControllerTests: XCTestCase {
    var sut: ArticleDetailViewController!
    var mockViewModel: MockArticleDetailViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Article", bundle: nil)
        sut = storyboard.instantiateViewController(
            identifier: ArticleDetailViewController.identifier) as? ArticleDetailViewController
        mockViewModel = MockArticleDetailViewModel()
        sut.viewModel = mockViewModel
        cancellables = []
        
        // Load view hierarchy
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockViewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Initial Setup
    func test_viewDidLoad_setsScreenTitle() {
        sut.viewDidLoad()
        XCTAssertEqual(sut.title, mockViewModel.screenTitle)
    }
    
    // MARK: - UI Updates
    func test_updateUI_setsCorrectLabels() {
        guard let testArticle = TestArticleProvider.createMockArticle() else {
            XCTFail("Failed to create mock article")
            return
        }
        sut.updateUI(with: testArticle)
        
        XCTAssertEqual(sut.titleLabel.text, testArticle.title)
        XCTAssertEqual(sut.detailLabel.text, testArticle.abstract)
        XCTAssertEqual(sut.externalLinkTextView.text, testArticle.url)
        XCTAssertEqual(sut.articleImage.image, UIImage(named: "article_image"))
    }
    
    func test_publisherUpdate_triggersUIUpdate() {
        guard let testArticle = TestArticleProvider.createMockArticle() else {
            XCTFail("Failed to create mock article")
            return
        }
        sut.viewDidLoad()
        mockViewModel.simulateShowArticleDetail(testArticle)

        XCTAssertEqual(sut.titleLabel.text, testArticle.title)
        XCTAssertEqual(sut.detailLabel.text, testArticle.abstract)
    }
}

