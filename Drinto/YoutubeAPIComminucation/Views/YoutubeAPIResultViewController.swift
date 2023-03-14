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
    @IBOutlet private weak var executingIndicator: UIActivityIndicatorView!

    private var youtubeResultDatas = [YoutubeDataModel]()

    private var fetchYoutubeDataModel = FetchDataModel()
    private var youtubeAPIPresenter: YoutubeAPIPresenterInput!

    private var selectYoutubeData = YoutubeDataModel(
        videoId: nil,
        title: nil,
        description: nil,
        thumbnailImageURLString: nil,
        channelTitle: nil,
        publishTime: nil
    )

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
        executingIndicator.isHidden = false
    }

    private func hiddenIndicator() {
        if executingIndicator.isHidden {
            executingIndicator.isHidden = false
        } else {
            executingIndicator.isHidden = true
        }
    }

    private func setThumbnailImage(cell: YoutubeAPIResultTableViewCell, image: UIImage) {
        cell.thumbnailImageView?.image = image
    }

    private func setEmptyArray() {
        youtubeResultDatas = []
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
        executingIndicator.isHidden = false
    }
}

extension YoutubeAPIResultViewController: UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "YoutubePlayerVC" {
            let youtubePlayerVC = segue.destination as? YoutubePlayerViewController
            youtubePlayerVC?.youtubeData = self.selectYoutubeData
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !youtubeResultDatas.isEmpty {
            self.selectYoutubeData = youtubeResultDatas[indexPath.row]
            performSegue(withIdentifier: "YoutubePlayerVC", sender: nil)
        }
        resultTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension YoutubeAPIResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if youtubeResultDatas.isEmpty {
            return 1
        }
        return youtubeResultDatas.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if youtubeResultDatas.isEmpty {
            print("CellForRowAt")
            print(Thread.current.isMainThread)
            let resultCell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
            var content = resultCell.defaultContentConfiguration()
            content.text = "データ取得失敗しました。ネット環境をお確かめの上，再度ご確認ください。"
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
        youtubeAPIPresenter.fetchThumbnailImageData(
            imageUrl: youtubeResultDatas[indexPath.row].thumbnailImageURLString ?? "",
            indexPath: indexPath
        )
        return resultCell
    }
}

extension YoutubeAPIResultViewController: YoutubeAPIPresenterOutput {
    func updateYoutubeData(youtubeDatas: [YoutubeDataModel]) {
        youtubeResultDatas = youtubeDatas
        Task.detached {
            await self.resultTableView.setContentOffset(.zero, animated: true)
            await self.resultTableView.layoutIfNeeded()
            await self.resultTableView.reloadData()
            await self.hiddenIndicator()
        }
    }

    func updateThumbnailImageData(thumbnailImage: UIImage, indexPath: IndexPath) {
        Task.detached {
            guard let cell = await self.resultTableView.cellForRow(at: indexPath) as? YoutubeAPIResultTableViewCell
            else {
                fatalError("Cellの取得に失敗")
            }
            await self.setThumbnailImage(cell: cell, image: thumbnailImage)
        }
    }

    func getError(apiError: Error) {
        Task.detached {
            await self.setEmptyArray()
            await self.resultTableView.reloadData()
            await self.hiddenIndicator()
        }
        print(apiError)
    }
}
