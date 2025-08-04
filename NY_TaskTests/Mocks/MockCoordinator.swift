//
//  MockCoordinator.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

@testable import NY_Task

class MockCoordinator: CoordinatorProtocol {
    // Tracking
    var navigateToDetailCalled = false
    var lastSelectedArticle: Article?
    
    func navigateToDetailScreen(with selectedArticle: Article) {
        navigateToDetailCalled = true
        lastSelectedArticle = selectedArticle
    }
}
