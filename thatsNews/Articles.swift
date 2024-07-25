//
//  Articles.swift
//  thatsNews
//
//  Created by Narissorn Chowarun on 2024-07-24.
//

import Foundation

struct NewsAPIResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
    static let `default` = NewsAPIResponse(status: "ok", totalResults: 0,
                                           articles: [Article]())
}
struct Article: Codable { let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
struct Source: Codable {
    let id: String?
    let name: String?
}
