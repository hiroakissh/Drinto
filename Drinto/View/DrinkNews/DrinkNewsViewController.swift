//
//  DrinkNewaViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class DrinkNewsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var fetchNewsDataModel = FetchDrinkNewsData()

    private var presenter: DrinkNewsPresenter!


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        presenter = DrinkNewsPresenter.init(with: self)
        presenter.viewDidLoad()
    }

    func loadData() {
        print(NewsData.self)
    }
}

extension DrinkNewsViewController: DrinkNewsPresenterOutput {
    func didFetch(_ drinkNews: [Article]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didFailToFetchDrinkNews(with error: Error) {
       print("Error")
    }

    func didPrepareInfomation(of newsData: Article) {
        print("OK")
        print(newsData.title)
    }
}

extension DrinkNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfNewsData
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DrinkNewsCell",
            for: indexPath
        )
        let drinkNews = presenter.newsData(forRow: indexPath.row)
        cell.textLabel?.text = drinkNews?.title
        return cell
    }
}

extension DrinkNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("CellTap")
        presenter.didSelectRowAt(indexPath)
    }
}
