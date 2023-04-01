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
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var publishLabel: UILabel!
    @IBOutlet private weak var channelLabel: UILabel!
    @IBOutlet private weak var openYoutubeApp: UIButton!

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
        playerView.load(
            withVideoId: videoId,
            playerVars: ["playsinline": 1]
        )
        view.addSubview(playerView)
        // Youtubeアプリに画面遷移するボタンなどの用意
        channelLabel.text = channelTitle
        publishLabel.text = publishTime
        guard let description = youtubeData.description else { return }
        descriptionLabel.text = description
    }
}

extension YoutubePlayerViewController: YTPlayerViewDelegate {
    
}
