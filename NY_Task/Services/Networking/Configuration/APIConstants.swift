//
//  APIConstants.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

import Foundation

/// This file contains constants used throughout the API configuration.
enum APIConstants {
   
    enum networkFile {
        static let fileName = "APIEndpoints"
        enum Keys {
            static let baseURL = "baseURL"
            static let endpoints = "endpoints"
            static let path = "path"
            static let method = "method"
        }
    }

    enum EndpointKeys {
        static let mostPopular = "mostPopular"
    }

    enum PathComponent {
        static let section = "section"
        static let period = "period"
        
        enum Value {
            static let allSection = "all-sections"
            static let sevenDay = "7"
        }
    }

    enum Query {
        static let apiKey = "api-key"
    }

    enum Header {
        static let contentType = "Content-Type"
        static let accept = "Accept"

        enum Value {
            static let json = "application/json"
        }
    }
    
    enum APIKeys {
        static var nytApiKey: String {
            /// Fetch the API key from the Secure.xcconfig using Info.plist file
            Bundle.main.object(forInfoDictionaryKey: "nyTimesApiKey") as? String ?? ""
        }
    }
}
