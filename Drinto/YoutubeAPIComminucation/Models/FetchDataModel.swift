//
//  FetchDataModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/28.
//

import Foundation

enum APIClientError: Error {
    case invalidURL
    case responseError
    case serverError
    case noData
    case badStatus
    case transRateDataError
}

final class FetchDataModel {
    private let apiKey = "AIzaSyDfxvt9Eu7fWjgVKguQNWTAhXxuUIvUElI"
    var youtubeDatas = [YoutubeDataModel]()

    func fetchYoutubeData(searchTitle: String) async throws -> [YoutubeDataModel] {
        let searchTitle = String()
//        var urlString = "https://www.googleapis.com/youtube/v3/search?key=\(apiKey)&part=snippet&q=\(searchTitle)&maxResults=3"
        var urlString = "https://www.googleaps.com/youtube/v3/search?key=\(apiKey)&part=snippet&q=\(searchTitle)&maxResults=3"
        let apiUrl = URL(string: urlString)
        guard let apiUrl = apiUrl else {
            throw APIClientError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: apiUrl)
            guard let httpStatus = response as? HTTPURLResponse else {
                throw APIClientError.responseError
            }
            switch httpStatus.statusCode {
            case 200 ..< 400:
                do {
                    let responseDatas = try JSONDecoder().decode(YoutubeAPIResult.self, from: data)
                    youtubeDatas = responseDatas.items.map({ item in
                        let youtubeData = YoutubeDataModel(
                            videoId: item.snippet.channelId,
                            title: item.snippet.title,
                            description: item.snippet.description,
                            thumbnailImageURLString: item.snippet.thumbnails.medium.url,
                            channelTitle: item.snippet.channelTitle,
                            publishTime: item.snippet.publishedAt
                        )
                        return youtubeData
                    })
                } catch {
                    print(error.localizedDescription)
                    throw APIClientError.transRateDataError
                }
                return youtubeDatas
            case  400...:
                throw APIClientError.badStatus
            default:
                fatalError("予期せぬステータスコード")
                break
            }
        } catch {
            throw APIClientError.serverError
        }
    }
}
