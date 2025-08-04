//
//  EndpointProvider.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//
import Foundation

/// This file provides a way to retrieve API endpoint configurations from a plist file.
struct EndpointProvider {
    enum Error: Swift.Error {
        case missingKey(String)
        case invalidMethod(String)
    }
    
    /// Retrieves baseURL from the plist file.
    static func baseURL() throws -> String {
        guard let url = plist?[APIConstants.networkFile.Keys.baseURL] as? String else {
            throw Error.missingKey(APIConstants.networkFile.Keys.baseURL)
        }
        return url
    }
    
    /// Retrieves the endpoint configuration for a given key from the plist file.
    static func endpointConfig(for key: String) throws -> (path: String, method: HTTPMethod) {
        /// Ensure the endpoints dictionary is present in the plist
        guard let endPoints = plist?[APIConstants.networkFile.Keys.endpoints] as? [String: Any],
            let dict = endPoints[key] as? [String: Any] else {
            throw Error.missingKey(key)
        }
        /// Ensure the path is present in the dictionary
        guard let path = dict[APIConstants.networkFile.Keys.path] as? String else {
            throw Error.missingKey("\(key).\(APIConstants.networkFile.Keys.path)")
        }
        /// Ensure the method(GET/POST) is present and valid in the dictionary
        guard let methodString = dict[APIConstants.networkFile.Keys.method] as? String,
              let method = HTTPMethod(rawValue: methodString) else {
            throw Error.invalidMethod("\(key).\(APIConstants.networkFile.Keys.method)")
        }
        /// Return the path and method as a tuple
        return (path, method)
    }
    
    /// Private function to load the plist file and return its contents as a dictionary.
    private static var plist: [String: Any]? {
        guard let url = Bundle.main.url(forResource: APIConstants.networkFile.fileName, withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] else {
            return nil
        }
        return plist
    }
}
