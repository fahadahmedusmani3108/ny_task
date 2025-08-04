//
//  ArticleBaseViewModelAdaptable.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 02/08/2025.
//

/// This protocol defines the displayable properties.
/// It is intended to be used as a base for other view model displayables.
protocol ArticleBaseViewModelDisplayable {
    /// The title of the screen to be displayed.
    var screenTitle: String { get }
}

/// This protocol defines the actionable methods.
/// It is intended to be used as a base for other view model actionables.
protocol ArticleBaseViewModelActionable {
    /// Method to load the UI elements.
    func loadUI()
}
