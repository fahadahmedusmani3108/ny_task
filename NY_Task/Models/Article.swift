//
//  Article.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

struct Article: Codable {
    let uri: String?
    let url: String?
    let id: Int?
    let source: String?
    let updated: String?
    let section: String?
    let subsection: String?
    let nytdsection: String?
    let column: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    let media: [ArticleMedia]?
}
