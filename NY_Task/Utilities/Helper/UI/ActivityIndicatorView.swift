//
//  ActivityIndicatorView.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import UIKit

/// A custom activity indicator view that displays a spinner with a semi-transparent background.
/// It provides methods to start and stop the animation, and it hides itself when not animating
final class ActivityIndicatorView: UIView {
    // MARK: - Properties
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Public Methods
    func startAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.startAnimating()
            self?.isHidden = false
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
            self?.isHidden = true
        }
    }
}
