//
//  YoutubePlayerViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/03/12.
//

import UIKit
import AVKit
import AVFoundation
import YouTubeiOSPlayerHelper

class YoutubePlayerViewController: UIViewController {
    @IBOutlet private var playerView: YTPlayerView!
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
        // ステータスバーの高さ取得
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        // ナビゲーションバーの高さ取得
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        playerView = YTPlayerView(
            frame: CGRect(
                x: 0,
                y: statusBarHeight + navBarHeight!,
                width: view.frame.size.width,
                height: 240
            )
        )
        playerView.delegate = self
        print(videoId)
        playerView.load(
            withVideoId: videoId,
            playerVars: ["playsinline": 1]
        )
        view.addSubview(playerView)
        // Youtubeアプリに画面遷移するボタンなどの用意
        // Youtubeの説明
        // Youtubeチャンネル名
        // 更新日を画面下側に表示
    }
}

extension YoutubePlayerViewController: YTPlayerViewDelegate {
    
}
