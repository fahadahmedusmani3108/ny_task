//
//  ArticleListViewModel.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 02/08/2025.
//
import Combine

/// ViewModel for managing the article list screen.
class ArticleListViewModel {
    private let repository: ArticleRepositoryProtocol
    private let coordinator: CoordinatorProtocol?
    private var cancellables = Set<AnyCancellable>()
    @Published private var articleListItems: [ArticleListItem] = []
    @Published private var error: Error?
    @Published private var isLoading = false
    
    init(repository: ArticleRepositoryProtocol, coordinator: CoordinatorProtocol) {
        self.repository = repository
        self.coordinator = coordinator
    }
}

/// Extension for displayable properties in the ArticleListViewModel.
extension ArticleListViewModel: ArticleListViewModelDisplayable {
    var screenTitle: String {
        return ArticleUIString.articleListTitle.localized
    }
}

/// Extension for actionable methods in the ArticleListViewModel.
extension ArticleListViewModel: ArticleListViewModelActionable {
    var showArticlePublisher: AnyPublisher<[ArticleListItem], Never> {
           $articleListItems.eraseToAnyPublisher()
    }

    var errorPublisher: AnyPublisher<Error, Never> {
            $error.compactMap { $0 }.eraseToAnyPublisher()
    }

    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }

    func loadUI() {
        getArticles()
    }

    /// Handles the selection of a row in the article list.
    func didSelectRowAt(at index: Int) {
        do {
            let selectedArticle = try repository.getArticle(at: index)
            coordinator?.navigateToDetailScreen(with: selectedArticle)
        } catch {
            self.error = error
        }
    }
}

private extension ArticleListViewModel {
    /// Fetches popular articles from the repository and updates the article list items.
    func getArticles() {
        isLoading = true
        Task {
            do {
                articleListItems = try await repository.getPopularArticles(section: APIConstants.PathComponent.Value.allSection,
                                                              period: APIConstants.PathComponent.Value.sevenDay,
                                                              apiKey: APIConstants.APIKeys.nytApiKey)
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}
