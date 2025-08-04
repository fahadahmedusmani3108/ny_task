//
//  ArticleDetailViewModelAdaptable.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import Combine

/// It is used to provide a complete interface for the view model, allowing the view controller to
/// access both displayable properties and actionable methods.
/// It is used to ensure that the view controller can interact with the view model in a type
/// safe manner.
typealias ArticleDetailViewModelAdaptable = ArticleDetailViewModelDisplayable & ArticleDetailViewModelActionable

/// This protocol defines the displayable properties for the ArticleDetailViewModel.
protocol ArticleDetailViewModelDisplayable: ArticleBaseViewModelDisplayable {}

/// This protocol defines the actionable methods for the ArticleDetailViewModel.
protocol ArticleDetailViewModelActionable: ArticleBaseViewModelActionable {
    var showDetailPublisher: PassthroughSubject<Article, Never> { get }
}
