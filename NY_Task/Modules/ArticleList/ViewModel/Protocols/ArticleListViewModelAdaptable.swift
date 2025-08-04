//
//  ArticleListViewModelAdaptable.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 02/08/2025.
//

import Combine

/// It is used to provide a complete interface for the view model, allowing the view controller to
/// access both displayable properties and actionable methods.
/// It is used to ensure that the view controller can interact with the view model in a type
/// safe manner.
typealias ArticleListViewModelAdaptable = ArticleListViewModelDisplayable & ArticleListViewModelActionable

/// This protocol defines the displayable properties for the ArticleListViewModel.
protocol ArticleListViewModelDisplayable: ArticleBaseViewModelDisplayable {}

/// This protocol defines the actionable methods for the ArticleListViewModel.
protocol ArticleListViewModelActionable: ArticleBaseViewModelActionable {
    var showArticlePublisher: AnyPublisher<[ArticleListItem], Never> { get }
    var errorPublisher: AnyPublisher<Error, Never> { get }
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }
    func didSelectRowAt(at index: Int)
}
