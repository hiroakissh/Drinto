//
//  NewsDataModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/29.
//

import Foundation

enum NetworkError: Error {
    case unowned
    case invalidResponse
    case invalidURL
}

struct Source: Codable {
    var name: String
}

struct Article: Codable {
    var source: Source
    var title: String
    var url: String
    var urlToImage: String
}

struct NewsData: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}
