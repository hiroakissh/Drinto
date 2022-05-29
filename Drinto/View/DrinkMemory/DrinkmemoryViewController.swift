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
    }
}

extension DrinkMemoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinkCell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath)

        return drinkCell
    }
}
