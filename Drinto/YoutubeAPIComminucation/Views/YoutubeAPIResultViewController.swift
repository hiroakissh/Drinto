//
//  TwitterAPIResultViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/20.
//

import UIKit

class TwitterAPIResultViewController: UIViewController {
    @IBOutlet private weak var tweetResultTableView: UITableView!

    private var tweets: [TweetModel] = []

    private var testAPI = TwitterAPIPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

//        Task {
//            try await testAPI.getTimeLine()
//        }
        print("1")
        testAPI.getTimeLine()
        print("2")

        tweetResultTableView.dataSource = self
        tweetResultTableView.delegate = self

        // ダミー
        let testUser = TwitterUserModel(
            id: "1234",
            userId: "5678",
            userName: "testUser",
            profileImageURL: "https://test"
        )

        let testTweet = TweetModel(id: "91011", text: "テスト", user: testUser)

        tweets.append(testTweet)
        tweetResultTableView.reloadData()
    }
}

extension TwitterAPIResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップ")
    }
}

extension TwitterAPIResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        var content = tweetCell.defaultContentConfiguration()
        content.text = tweets[0].text
        tweetCell.contentConfiguration = content
        return tweetCell
    }
}
