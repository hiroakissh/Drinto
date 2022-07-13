//
//  DrinkmemoryViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class DrinkMemoryViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var drinkMemory = DrinkMemoryRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Swift型データ")
        print(drinkMemory.readDrinkMemoryData())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: "DrinkMemoryTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DrinkMemoryCell"
        )
        tableView.layer.cornerRadius = 10.0
    }
}

extension DrinkMemoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkMemory.readDrinkMemoryData().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let indexDrinkMemory = drinkMemory.readDrinkMemoryData()[indexPath.row]
        let drinkCell = tableView.dequeueReusableCell(
            withIdentifier: "DrinkMemoryCell",
            for: indexPath
            // swiftlint:disable:next force_cast
        ) as! DrinkMemoryTableViewCell
        drinkCell.drinkNameLabel.text = indexDrinkMemory.drinkName
        drinkCell.categoryLabel.text = indexDrinkMemory.category
        // TODO: Imagepathに関しての追記
        if indexDrinkMemory.imagePath != nil {
            drinkCell.drinkImageView.image = UIImage(contentsOfFile: indexDrinkMemory.imagePath ?? "")
        }
        return drinkCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
