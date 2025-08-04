//
//  ArticleMedia.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 03/08/2025.
//

struct ArticleMedia: Codable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [ArticleMediaMetadata]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}
