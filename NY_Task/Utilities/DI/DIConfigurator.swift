//
//  DIConfigurator.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import UIKit

/// This class is responsible for configuring the dependency injection container and registering all the necessary services and repositories.
/// It uses a singleton pattern to ensure that the configuration is done only once throughout the app lifecycle.
final class DIConfigurator {
    
    /// Configures the dependency injection container with all the necessary services and repositories.
    static func configure(with navigationController: UINavigationController? = nil) {
        let container = DIContainer.shared
        
        /// registering apiClient
        container.registerSingleton(APIClient.self) {
            APIClient()
        }
        
        /// registering services
        container.registerSingleton(ArticleNetworkService.self) {
            ArticleNetworkService(client: container.resolve(APIClient.self))
        }
        
        /// registering viwew model factory
        container.registerSingleton(ViewModelFactory.self) {
            ViewModelFactory(container: container)
        }
        
        /// registering repositories
        container.register(ArticleRepository.self) {
            ArticleRepository(
                networkService: container.resolve(ArticleNetworkService.self)
            )
        }
        
        /// registering coordinator
        container.register(Coordinator.self) {
            Coordinator(navigationController: navigationController ?? UINavigationController(),
                                container: container,
                                viewModelFactory: container.resolve(ViewModelFactory.self))
        }
    }
}
