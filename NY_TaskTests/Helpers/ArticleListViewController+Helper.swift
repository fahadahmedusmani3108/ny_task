//
//  ArticleListViewController+Helper.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import Combine
import UIKit
@testable import NY_Task

extension ArticleListViewController {
    static func make(viewModel: ArticleListViewModelAdaptable) -> ArticleListViewController {
        let storyboard = UIStoryboard(name: "Article", bundle: nil)
        let controller = storyboard.instantiateViewController(
            withIdentifier: "ArticleListViewController"
        ) as! ArticleListViewController
        controller.viewModel = viewModel
        return controller
    }
}
