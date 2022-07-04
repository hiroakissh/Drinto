//
//  DrinkNewaViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class DrinkNewsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var newsDataModel = NewsDataModel()

    var newsData = [NewsData]()
    var newsTotalCount = 1
    var newsDataTest: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        newsDataModel.getNewsFromNewsAPI(completionHandler: { newsDataFromAPI in
            self.newsData = [newsDataFromAPI]
            self.newsTotalCount = newsDataFromAPI.totalResults
            self.newsDataTest = newsDataFromAPI.articles
            print(self.newsDataTest[0].title)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })

        tableView.dataSource = self
        tableView.delegate = self
    }

    func loadData() {
        print(NewsData.self)
    }
}
extension DrinkNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataTest.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinkNewsCell = tableView.dequeueReusableCell(withIdentifier: "DrinkNewsCell", for: indexPath)
        if newsDataTest.count == 0 {
            drinkNewsCell.textLabel?.text = "データを取得中"
        } else {
            drinkNewsCell.textLabel?.text = newsDataTest[indexPath.row].title
        }
        return drinkNewsCell
    }
}

// 84b4753e4e64481280f134d01ddfe9af
