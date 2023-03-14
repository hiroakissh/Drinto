//
//  YoutubePlayerViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/03/12.
//

import UIKit
import YouTubeiOSPlayerHelper

class YoutubePlayerViewController: UIViewController {
    @IBOutlet private weak var playerView: YTPlayerView!
    @IBOutlet private weak var youtubeTitle: UILabel!

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
        guard let videoId = youtubeData.videoId,
              let title = youtubeData.title,
              let channelTitle = youtubeData.channelTitle,
              let publishTime = youtubeData.publishTime
        else { return }
        navigationItem.title = title
        playerView.delegate = self
        print(videoId)
        self.playerView.load(
            withVideoId: videoId,
            playerVars: ["playsinline": 1]
        )
        // Youtubeアプリに画面遷移するボタンなどの用意
        // Youtubeの説明
        // Youtubeチャンネル名
        // 更新日を画面下側に表示
    }
}

extension YoutubePlayerViewController: YTPlayerViewDelegate {
    
}
