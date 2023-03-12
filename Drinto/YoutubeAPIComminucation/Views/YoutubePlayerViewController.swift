//
//  YoutubePlayerViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/03/12.
//

import UIKit

class YoutubePlayerViewController: UIViewController {
    var youtubeData = YoutubeDataModel(
        videoId: nil,
        title: nil,
        description: nil,
        thumbnailImageURLString: nil,
        channelTitle: nil,
        publishTime: nil
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        print(youtubeData)
    }
}
