//
//  UIComposer.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import UIKit

/// A protocol that defines methods for composing UI components such as loading views and alerts.
/// This protocol is intended to be adopted by view controllers to provide a consistent way to manage loading states and alerts across the application.
/// It provides default implementations for showing and hiding a loading view, as well as presenting alerts.
protocol UIComposer: AnyObject {
    var loadingView: ActivityIndicatorView { get }
    
    func setupLoadingView()
    func showLoader()
    func hideLoader()
    func showAlert(title: String,
                   message: String,
                   actions: [UIAlertAction],
                   completion: (() -> Void)?)
}

extension UIComposer where Self: UIViewController {

    /// Initializes the loading view and adds it to the view controller's view.
    func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        loadingView.isHidden = true
    }
    
    /// Shows the loading view by bringing it to the front and starting the animation.
    func showLoader() {
        view.bringSubviewToFront(loadingView)
        loadingView.startAnimating()
    }
    
    /// Hides the loading view by stopping the animation.
    func hideLoader() {
        loadingView.stopAnimating()
    }
    
    /// Displays an alert with the specified title, message, and actions.
    func showAlert(title: String,
                   message: String,
                   actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)],
                   completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            actions.forEach { alert.addAction($0) }
            
            self?.present(alert, animated: true, completion: completion)
        }
    }
}
