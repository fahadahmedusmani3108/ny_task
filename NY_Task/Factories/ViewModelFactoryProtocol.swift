//
//  ViewModelFactoryProtocol.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

protocol ViewModelFactoryProtocol {
    func makeArticleListViewModel() -> ArticleListViewModel
    func makeArticleDetailViewModel(with selectedArticle: Article) -> ArticleDetailViewModel
}
