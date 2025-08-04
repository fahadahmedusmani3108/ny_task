//
//  ArticleListTableViewCell.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var articleImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var subtitleLabel: UILabel!
    @IBOutlet private(set) weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        articleImageView.layer.cornerRadius = 20.0
    }

    func configure(with article: ArticleListItem) {
        titleLabel.text = article.title
        subtitleLabel.text = article.subtitle
        dateLabel.text = article.date
        articleImageView?.image = article.image
    }
}
