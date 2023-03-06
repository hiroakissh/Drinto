//
//  YoutubeAPIPresenter.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/20.
//

import Foundation

protocol YoutubeAPIPresenterInput {
    func fetchYoutubeData(searchTitle: String)
}

protocol YoutubeAPIPresenterOutput {
    func updateYoutubeData(youtubeDatas: [YoutubeDataModel])
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
}
