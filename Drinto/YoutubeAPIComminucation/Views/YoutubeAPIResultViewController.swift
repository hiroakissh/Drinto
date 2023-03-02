//
//  YoutubeAPIResultViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/20.
//

import UIKit

class YoutubeAPIResultViewController: UIViewController {
    @IBOutlet private weak var resultTableView: UITableView!

    private var fetchYoutubeDataModel = FetchDataModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            try await fetchYoutubeDataModel.fetchYoutubeData(searchTitle: "ねこ")
        }

        resultTableView.dataSource = self
        resultTableView.delegate = self

        resultTableView.reloadData()
    }
}

extension YoutubeAPIResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップ")
    }
}

extension YoutubeAPIResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        var content = tweetCell.defaultContentConfiguration()
        content.text = "test"
        tweetCell.contentConfiguration = content
        return tweetCell
    }
}
