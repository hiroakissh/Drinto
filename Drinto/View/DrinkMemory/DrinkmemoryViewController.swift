//
//  DrinkmemoryViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class DrinkMemoryViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: "DrinkMemoryTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DrinkMemoryCell"
        )
    }
}

extension DrinkMemoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinkCell = tableView.dequeueReusableCell(
            withIdentifier: "DrinkMemoryCell",
            for: indexPath
            // swiftlint:disable:next force_cast
        ) as! DrinkMemoryTableViewCell
        return drinkCell
    }
}
