//
//  APIClientProtocol.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//
import Foundation

protocol APIClientProtocol {
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
}
