//
//  DIContainer.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//
import Foundation

/// A simple Dependency Injection Container that allows for registering and resolving dependencies.
/// It supports both factory-based instantiation and singleton registration.
final class DIContainer {
    
    // MARK: - Singleton
    static let shared = DIContainer()
    
    // MARK: - Internal Stores
    private var factories: [ObjectIdentifier: () -> Any] = [:]
    private var singletons: [ObjectIdentifier: Any] = [:]
    
    private init() {}
    
    // MARK: - Register Factory
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        factories[ObjectIdentifier(type)] = factory
    }
    
    // MARK: - Register Singleton (Lazy)
    func registerSingleton<T>(_ type: T.Type, factory: @escaping () -> T) {
        factories[ObjectIdentifier(type)] = { [weak self] in
            if let instance = self?.singletons[ObjectIdentifier(type)] as? T {
                return instance
            }
            let newInstance = factory()
            self?.singletons[ObjectIdentifier(type)] = newInstance
            return newInstance
        }
    }

    // MARK: - Resolve Dependency
    func resolve<T>(_ type: T.Type) -> T {
        guard let factory = factories[ObjectIdentifier(type)],
              let instance = factory() as? T else {
            fatalError("No factory registered for type \(T.self)")
        }
        return instance
    }

    // MARK: - Reset (optional)
    func reset() {
        factories.removeAll()
        singletons.removeAll()
    }
}
