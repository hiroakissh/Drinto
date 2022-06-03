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

class NewsDataModel {
    let apiKey = "84b4753e4e64481280f134d01ddfe9af"
    let urlHead = "https://newsapi.org/v2/everything?"
    let sort = "popularity"
    var category = "tea"

    func getNewsFromNewsAPI(completionHandler: @escaping(NewsData) -> Void) {
        let newsURLString = "\(urlHead)q=\(category)&apiKey=\(apiKey)"
        print(newsURLString)
        guard let url = URL(string: newsURLString) else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: urlRequest) { data, URLResponse, error in
            if error != nil {
                print("Error")
                print(error.debugDescription)
            }
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let jsonDecoderData = try jsonDecoder.decode(NewsData.self, from: data)
                    completionHandler(jsonDecoderData)
                } catch {
                    print("Decode Error")
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
