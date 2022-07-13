//
//  DetailDrinkMemoryViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/07/13.
//

import UIKit

class DetailDrinkMemoryViewController: UIViewController {

    var detailDrinkMemory = DrinkMemorySwiftModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailDrinkMemory)
        print("Drink名前")
        print(detailDrinkMemory.drinkName ?? "")
        print("Drinkカテゴリー")
        print(detailDrinkMemory.category ?? "")
        print("ドリンクポイント")
        print(detailDrinkMemory.drinkPoint?[0])
        print(detailDrinkMemory.drinkPoint?[1])
        print(detailDrinkMemory.drinkPoint?[2])
        print(detailDrinkMemory.drinkPoint?[3])
        print(detailDrinkMemory.drinkPoint?[4])
        print(detailDrinkMemory.drinkPoint?[5])
    }
}
