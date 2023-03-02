//
//  YoutubeAPIDecordModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/03/02.
//

import Foundation

struct YoutubeAPIResult: Decodable {
    var items: [Items]
}
struct Items: Decodable {
    var snippet: YoutubeDatas
}
struct YoutubeDatas: Decodable {
    var publishedAt: String?
    var channelId: String?
    var title: String?
    var description: String?
    var thumbnails: Thumbnails
    var channelTitle: String?
}

struct Thumbnails: Decodable {
    var medium: ThumbnailData
}

struct ThumbnailData: Decodable {
    var url: String
}
