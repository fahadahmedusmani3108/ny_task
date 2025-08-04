//
//  ViewModelFactory.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

///  This factory is responsible for creating view models used in the application.
final class ViewModelFactory: ViewModelFactoryProtocol {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    /// Creates an instance of `ArticleListViewModel`.
    func makeArticleListViewModel() -> ArticleListViewModel {
        ArticleListViewModel(
            repository: container.resolve(ArticleRepository.self), coordinator: container.resolve(Coordinator.self)
        )
    }
    
    /// Creates an instance of `ArticleDetailViewModel` with the provided selected article.
    func makeArticleDetailViewModel(with selectedArticle: Article) -> ArticleDetailViewModel {
        ArticleDetailViewModel(
            selectedArticle: selectedArticle
        )
    }
}
