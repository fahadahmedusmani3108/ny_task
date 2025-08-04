//
//  ArticleListViewControllerTests.swift
//  NY_TaskTests
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import XCTest
@testable import NY_Task
import Combine

final class ArticleListViewControllerTests: XCTestCase {
    
    var sut: ArticleListViewController!
    var mockViewModel: MockArticleListViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockArticleListViewModel()
        cancellables = []
        
        let storyboard = UIStoryboard(name: "Article", bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: String(describing: ArticleListViewController.self)
        ) as? ArticleListViewController
        
        sut.viewModel = mockViewModel
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockViewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_setsUpTableView() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertEqual(sut.title, mockViewModel.screenTitle)
    }
    
    // MARK: - TableView Data Tests
    func test_numberOfRowsInSection() {
        // Given
        let testArticles = [
            ArticleListItem(title: "Test 1", subtitle: nil, date: nil, image: nil),
            ArticleListItem(title: "Test 2", subtitle: nil, date: nil, image: nil)
        ]
        mockViewModel.simulateArticles(testArticles)
        
        // When
        let rows = sut.tableView.numberOfRows(inSection: 0)
        
        // Then
        XCTAssertEqual(rows, testArticles.count)
    }
    
    func test_cellForRowAt_configuresCell() {
        // Given
        let testItem = ArticleListItem(
            title: "Test Title",
            subtitle: "Test Subtitle",
            date: "2023-01-01",
            image: nil
        )
        mockViewModel.simulateArticles([testItem])
        
        // When
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ArticleListTableViewCell
    
        // Then
        XCTAssertEqual(cell?.titleLabel.text, testItem.title)
        XCTAssertEqual(cell?.subtitleLabel.text, testItem.subtitle)
        XCTAssertEqual(cell?.dateLabel.text, testItem.date)
    }
    
    // MARK: - Loading State Tests
    func test_loadingStateChanges() {
        // Given
        let expectation = self.expectation(description: "Loading state changes")
        var loadingStates = [Bool]()
        
        sut.viewModel?.isLoadingPublisher
            .sink { isLoading in
                loadingStates.append(isLoading)
                if loadingStates.count == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        mockViewModel.simulateLoading(true)
        mockViewModel.simulateLoading(false)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(loadingStates, [true, false])
    }
    
    // MARK: - User Interaction Tests
    func test_didSelectRowAt() {
        // Given
        let testArticles = [
            ArticleListItem(title: "Test", subtitle: nil, date: nil, image: nil)
        ]
        mockViewModel.simulateArticles(testArticles)
        let testIndexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
        
        // Then
        XCTAssertEqual(mockViewModel.selectedIndex, 0)
    }
}
