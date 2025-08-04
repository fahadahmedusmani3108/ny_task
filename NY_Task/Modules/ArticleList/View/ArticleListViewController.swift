//
//  ArticleListViewController.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 02/08/2025.
//

import UIKit
import Combine

/// This view controller displays a list of articles using a table view and manages the data source with Combine for reactive updates.
class ArticleListViewController: UIViewController, UIComposer {
    @IBOutlet private(set) weak var tableView: UITableView!
    
    /// A data source for the table view that uses diffable data source to manage the articles.
    private var dataSource: UITableViewDiffableDataSource<Section, ArticleListItem>!
    private var cancellables = Set<AnyCancellable>()

    /// A loading view that displays an activity indicator while data is being fetched.
    lazy var loadingView: ActivityIndicatorView = {
            ActivityIndicatorView(frame: view.bounds)
    }()
    var viewModel: ArticleListViewModelAdaptable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        viewModel?.loadUI()
    }
}

private extension ArticleListViewController {
    /// Sets up the user interface components of the view controller.
    func setupUI() {
        title = viewModel?.screenTitle
        setupLoadingView()
        setupTableView()
        setupDataSource()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.register(UINib(nibName: ArticleListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ArticleListTableViewCell.identifier)
    }

    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, ArticleListItem>(
            tableView: tableView,
            cellProvider: { [weak self] tableView, indexPath, item in
                return self?.getCell(for: item, at: indexPath, in: tableView)
            }
        )
    }

    /// Applies a snapshot to the data source with the provided article list items.
    func applySnapshot(with data: [ArticleListItem], animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ArticleListItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }

    /// sets up viewmodel to handle data updates and user interactions.
    func setupViewModel() {
        viewModel?.showArticlePublisher.sink(receiveValue: {[weak self] articleListItems in
            self?.applySnapshot(with: articleListItems)
        }).store(in: &cancellables)
        
        viewModel?.errorPublisher.sink(receiveValue: { [weak self] error in
            self?.showAlert(title: ArticleUIString.alert.localized, message: error.localizedDescription)
        }).store(in: &cancellables)
        
        viewModel?.isLoadingPublisher.sink(receiveValue: { [weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }).store(in: &cancellables)
    }
}

/// Sets up tableview section and cell configuration.
private extension ArticleListViewController {
    enum Section {
        case main
    }
    func getCell(for item: ArticleListItem, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ArticleListTableViewCell.identifier,
            for: indexPath
        ) as? ArticleListTableViewCell else {
            return nil
        }
        cell.configure(with: item)
        return cell
    }
}

/// Handles user interactions with the table view
extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRowAt(at: indexPath.row)
    }
}
