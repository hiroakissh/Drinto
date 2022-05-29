//
//  NewsDataModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/29.
//

import Foundation

class NewsDataModel {
    var url: String
    var title: String

    init(url: String, title: String) {
        self.url = url
        self.title = title
    }
}
