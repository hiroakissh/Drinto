//
//  FetchDataModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/28.
//

import Foundation
import UIKit

enum APIClientError: Error {
    case invalidURL
    case responseError
    case serverError
    case noData
    case badStatus
    case transRateDataError
}

protocol FetchDataModelInput {
    func fetchYoutubeData(searchTitle: String) async throws -> [YoutubeDataModel]
}

final class FetchDataModel: FetchDataModelInput {
    var youtubeDatas = [YoutubeDataModel]()

    func fetchYoutubeData(searchTitle: String) async throws -> [YoutubeDataModel] {
        var urlString = "https://www.googleapis.com/youtube/v3/search?key=\(youtubeAccessToken)&part=snippet&q=\(searchTitle)&maxResults=20"
        let encoderUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let encoderUrlString = encoderUrlString else { throw APIClientError.invalidURL }
        let apiUrl = URL(string: encoderUrlString)
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
            }
        } catch {
            throw APIClientError.serverError
        }
    }

    func fetchThumbnailImage(imageUrlString: String) async throws -> UIImage {
        let imageUrl = URL(string: imageUrlString)
        guard let imageUrl = imageUrl else { throw APIClientError.invalidURL }
        do {
            let (data, response) = try await URLSession.shared.data(from: imageUrl)
            guard let httpStatus = response as? HTTPURLResponse else { throw APIClientError.responseError }
            switch httpStatus.statusCode {
            case 200 ..< 400:
                do {
                    guard let imageData = UIImage(data: data) else { throw APIClientError.noData }
                    return imageData
                } catch {
                    throw APIClientError.noData
                }
            case 400...:
                throw APIClientError.badStatus
            default:
                fatalError("予期せぬステータスコード")
            }
        } catch {
            throw APIClientError.serverError
        }
    }
}
