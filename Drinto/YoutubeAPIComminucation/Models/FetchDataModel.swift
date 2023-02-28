//
//  FetchDataModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/28.
//

import Foundation

final class FetchDataModel {

    private let apiKey = "AIzaSyDfxvt9Eu7fWjgVKguQNWTAhXxuUIvUElI"
    var youtubeDatas = [YoutubeDataModel]()

    func fetchYoutubeData(searchTitle: String) -> [YoutubeDataModel] {
        var searchTitle = String()
        var urlString = "https://www.googleapis.com/youtube/v3/search?key=\(apiKey)&part=snippet&q=\(searchTitle)&maxResults=50"

        return []
    }

}
