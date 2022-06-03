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

    var newsData: [NewsData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        newsDataModel.getNewsFromNewsAPI(completionHandler: { newsData in
            print(newsData)
        })

        tableView.dataSource = self
        tableView.delegate = self
    }

    func loadData() {
    }
}
extension DrinkNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinkNewsCell = tableView.dequeueReusableCell(withIdentifier: "DrinkNewsCell", for: indexPath)

        return drinkNewsCell
    }
}

// 84b4753e4e64481280f134d01ddfe9af
