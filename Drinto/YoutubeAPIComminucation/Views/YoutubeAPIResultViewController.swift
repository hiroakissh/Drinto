//
//  YoutubeAPIResultViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/20.
//

import UIKit

class YoutubeAPIResultViewController: UIViewController {
    @IBOutlet private weak var resultTableView: UITableView!
    @IBOutlet private weak var categorySegmentedControl: UISegmentedControl!

    private var youtubeResultDatas = [YoutubeDataModel]()

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

        resultTableView.register(UINib(
            nibName: "YoutubeAPIResultTableViewCell",
            bundle: nil
        ),
        forCellReuseIdentifier: "YoutubeResultCell")

        youtubeAPIPresenter.fetchYoutubeData(searchTitle: "飲み物")
        resultTableView.reloadData()
    }

    @IBAction private func selectCategory(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            youtubeAPIPresenter.fetchYoutubeData(searchTitle: "飲み物")
        case 1:
            youtubeAPIPresenter.fetchYoutubeData(searchTitle: "コーヒー")
        case 2:
            youtubeAPIPresenter.fetchYoutubeData(searchTitle: "紅茶")
        case 3:
            youtubeAPIPresenter.fetchYoutubeData(searchTitle: "日本茶")
        case 4:
            youtubeAPIPresenter.fetchYoutubeData(searchTitle: "中国茶")
        case 5:
            youtubeAPIPresenter.fetchYoutubeData(searchTitle: "新しい飲み物")
        default:
            break
        }
    }
}

extension YoutubeAPIResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップ")
    }
}

extension YoutubeAPIResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if youtubeResultDatas.isEmpty {
            return 1
        }
        return youtubeResultDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if youtubeResultDatas.isEmpty {
            print("CellForRowAt")
            print(Thread.current.isMainThread)
            let resultCell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
            var content = resultCell.defaultContentConfiguration()
            content.text = "データ取得なし"
            resultCell.contentConfiguration = content
            return resultCell
        }
        print("CellForRowAt2")
        print(Thread.current.isMainThread)
        // swiftlint:disable force_cast
        let resultCell = resultTableView.dequeueReusableCell(
            withIdentifier: "YoutubeResultCell",
            for: indexPath) as! YoutubeAPIResultTableViewCell
        resultCell.youtubeTitleLabel.text = youtubeResultDatas[indexPath.row].title ?? "取得エラー"
        resultCell.channelTitleLabel.text = youtubeResultDatas[indexPath.row].channelTitle ?? "取得エラー"
        resultCell.postDateLabel.text = youtubeResultDatas[indexPath.row].publishTime ?? "取得エラー"
        return resultCell
    }
}

extension YoutubeAPIResultViewController: YoutubeAPIPresenterOutput {
    func updateYoutubeData(youtubeDatas: [YoutubeDataModel]) {
        youtubeResultDatas = youtubeDatas
        Task.detached {
            await self.resultTableView.reloadData()
        }
    }

    func getError(apiError: Error) {
        print(apiError)
        print(type(of: apiError))
    }
}
