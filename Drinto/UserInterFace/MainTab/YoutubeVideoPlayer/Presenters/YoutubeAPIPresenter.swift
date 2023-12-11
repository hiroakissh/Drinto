//
//  YoutubeAPIPresenter.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/20.
//

import Foundation
import UIKit

protocol YoutubeAPIPresenterInput {
    func fetchYoutubeData(searchTitle: String)
    func fetchThumbnailImageData(imageUrl: String, indexPath: IndexPath)
}

protocol YoutubeAPIPresenterOutput {
    func updateYoutubeData(youtubeDatas: [YoutubeDataModel])
    func updateThumbnailImageData(thumbnailImage: UIImage, indexPath: IndexPath)
    func getError(apiError: Error)
}

class YoutubeAPIPresenter {
    private var youtubeAPIPresenter: YoutubeAPIPresenterOutput?

    var fetchDataModel = FetchDataModel()

    init(youtubeAPIPresenter: YoutubeAPIPresenterOutput) {
        self.youtubeAPIPresenter = youtubeAPIPresenter
    }
}

extension YoutubeAPIPresenter: YoutubeAPIPresenterInput {
    func fetchYoutubeData(searchTitle: String) {
        Task {
            do {
                let youtubeData = try await fetchDataModel.fetchYoutubeData(searchTitle: searchTitle)
                youtubeAPIPresenter?.updateYoutubeData(youtubeDatas: youtubeData)
            } catch {
                youtubeAPIPresenter?.getError(apiError: error)
            }
        }
    }

    func fetchThumbnailImageData(imageUrl: String, indexPath: IndexPath) {
        Task {
            do {
                let thumbnailImage = try await fetchDataModel.fetchThumbnailImage(imageUrlString: imageUrl)
                youtubeAPIPresenter?.updateThumbnailImageData(thumbnailImage: thumbnailImage, indexPath: indexPath)
            } catch {
                youtubeAPIPresenter?.getError(apiError: error)
            }
        }
    }
}
