//
//  Coordinator.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import UIKit

/// Defines the responsibilities of a coordinator in the application.
/// This class outlines methods for setting up the root view controller and screen navigations.
class Coordinator: CoordinatorProtocol {
    private let navigationController: UINavigationController
    private let container: DIContainer
    private let viewModelFactory: ViewModelFactoryProtocol
    private let storyboard = UIStoryboard(name: "Article", bundle: nil)

    init(navigationController: UINavigationController,
         container: DIContainer,
         viewModelFactory: ViewModelFactoryProtocol) {
        self.navigationController = navigationController
        self.container = container
        self.viewModelFactory = viewModelFactory
    }

    /// Sets up the root view controller of the application.
    func setupRootController() -> UIViewController? {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: ArticleListViewController.identifier) as? ArticleListViewController else {
            return nil
        }
        viewController.viewModel = viewModelFactory.makeArticleListViewModel()
        return viewController
    }

    /// Navigates to the detail screen with the selected article.
    func navigateToDetailScreen(with selectedArticle: Article) {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: ArticleDetailViewController.identifier) as? ArticleDetailViewController else {
            return
        }
        viewController.viewModel = viewModelFactory.makeArticleDetailViewModel(with: selectedArticle)
        navigationController.pushViewController(viewController, animated: true)
    }
}

