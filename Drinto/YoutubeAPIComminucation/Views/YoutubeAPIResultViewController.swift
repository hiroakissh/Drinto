//
//  YoutubeAPIResultViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/20.
//

import UIKit

class YoutubeAPIResultViewController: UIViewController {
    @IBOutlet private weak var resultTableView: UITableView! //{
//        didSet {
//            resultTableView.register(UINib(
//                nibName: "YoutubeAPIResultTableViewCell",
//                bundle: nil
//            ),
//            forCellReuseIdentifier: "YoutubeResultCell")
//        }
//    }

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

        print("ViewDidLoad")
        print(Thread.current.isMainThread)

        resultTableView.register(UINib(
            nibName: "YoutubeAPIResultTableViewCell",
            bundle: nil
        ),
        forCellReuseIdentifier: "YoutubeResultCell")

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
