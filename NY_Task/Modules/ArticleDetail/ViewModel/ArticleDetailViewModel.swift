//
//  ArticleDetailViewModel.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import Combine

/// ViewModel for handling the article detail view logic
class ArticleDetailViewModel {
    private var selectedArticle: Article
    let showDetailPublisher: PassthroughSubject<Article, Never> = PassthroughSubject<Article, Never>()

    init(selectedArticle: Article) {
        self.selectedArticle = selectedArticle
    }
}

extension ArticleDetailViewModel: ArticleDetailViewModelDisplayable {
    var screenTitle: String {
        return ArticleUIString.articleListTitle.localized
    }
}

extension ArticleDetailViewModel: ArticleDetailViewModelActionable {
    func loadUI() {
        showDetailPublisher.send(selectedArticle)
    }
}
