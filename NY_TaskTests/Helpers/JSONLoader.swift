//
//  JSONLoader.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//

import Foundation

enum JSONLoader {
    static func load<T: Decodable>(
        _ filename: String,
        as type: T.Type = T.self,
        in bundle: Bundle = .test,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        guard let url = bundle.url(forResource: filename, withExtension: ".json") else {
            throw MockError.fileNotFound(filename)
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch {
            throw MockError.decodingFailed(error)
        }
    }
    
    enum MockError: Error {
        case fileNotFound(String)
        case decodingFailed(Error)
    }
}

extension Bundle {
    static var test: Bundle {
        return Bundle(for: MockArticleRepository.self)
    }
}
