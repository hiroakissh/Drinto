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
    private var youtubeAPIPresenter: YoutubeAPIPresenterInput!

    func inject(youtubeAPIPresenter: YoutubeAPIPresenterInput) {
        self.youtubeAPIPresenter = youtubeAPIPresenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        youtubeAPIPresenter = YoutubeAPIPresenter(youtubeAPIPresenter: self)

        resultTableView.dataSource = self
        resultTableView.delegate = self

        resultTableView.reloadData()
    }
}

extension YoutubeAPIResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップ")
        youtubeAPIPresenter.fetchYoutubeData(searchTitle: "猫")
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

extension YoutubeAPIResultViewController: YoutubeAPIPresenterOutput {
    func updateYoutubeData(youtubeDatas: [YoutubeDataModel]) {
        print("Data Gets")
        print(youtubeDatas)
    }

    func getError(apiError: Error) {
        print(apiError)
        print(type(of: apiError))
    }
}
