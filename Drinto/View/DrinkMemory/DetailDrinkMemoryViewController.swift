//
//  DetailDrinkMemoryViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/07/13.
//

import UIKit

class DetailDrinkMemoryViewController: UIViewController {
    @IBOutlet private weak var drinkNameLabel: UILabel!
    @IBOutlet private weak var drinkCategoryLabel: UILabel!
    @IBOutlet private weak var drinkImageView: UIImageView!

    var detailDrinkMemory = DrinkMemorySwiftModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailDrinkMemory)
        print("Drink名前")
        print(detailDrinkMemory.drinkName ?? "")
        drinkNameLabel.text = detailDrinkMemory.drinkName
        print("Drinkカテゴリー")
        print(detailDrinkMemory.category ?? "")
        drinkCategoryLabel.text = detailDrinkMemory.category
        print("ドリンクポイント")
        print(detailDrinkMemory.drinkPoint?[0] ?? 0)
        print(detailDrinkMemory.drinkPoint?[1] ?? 0)
        print(detailDrinkMemory.drinkPoint?[2] ?? 0)
        print(detailDrinkMemory.drinkPoint?[3] ?? 0)
        print(detailDrinkMemory.drinkPoint?[4] ?? 0)
        print(detailDrinkMemory.drinkPoint?[5] ?? 0)
    }
}
