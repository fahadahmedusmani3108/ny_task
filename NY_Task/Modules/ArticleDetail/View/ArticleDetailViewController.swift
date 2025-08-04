//
//  ArticleDetailViewController.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//
import UIKit
import Combine

/// This view controller displays the details of a selected article.
class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var externalLinkTextView: UITextView!
    
    var viewModel: ArticleDetailViewModelAdaptable?
    private var cancellables = Set<AnyCancellable>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        viewModel?.loadUI()
    }
    
    /// Updates the UI with the article details.
    func updateUI(with article: Article) {
        titleLabel.text = article.title
        articleImage.image = #imageLiteral(resourceName: "article_image")
        detailLabel.text = article.abstract
        externalLinkTextView.text = article.url
    }
}

private extension ArticleDetailViewController {
    func setupUI() {
        title = viewModel?.screenTitle
    }
    
    /// Sets up the view model to handle updates.
    func setupViewModel() {
        viewModel?.showDetailPublisher.sink(receiveValue: { [weak self] selectedArticle in
            self?.updateUI(with: selectedArticle)
        }).store(in: &cancellables)
    }
}
