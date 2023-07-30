//
//  DetailDrinkViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/05/05.
//

import UIKit

class DetailDrinkViewController: UIViewController {
    @IBOutlet private weak var drinkNameLabel: UILabel!
    @IBOutlet private weak var drinkCategoryLabel: UILabel!
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var chartView: ChartView!

    var detailDrinkMemory = DrinkMemorySwiftModel()

    private var drinkImageModel = DrinkImageModel()

    private var drinkCategoryModel = DrinkCategoryModel()

    private var drinkCategory: DrinkCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        drinkNameLabel.text = detailDrinkMemory.drinkName
        drinkCategoryLabel.text = detailDrinkMemory.category

        drinkCategoryModel.drinkCategoryString = detailDrinkMemory.category

        chartView.configure(valueInfo:
                .init(
                    value1: detailDrinkMemory.drinkPoint?[0] ?? 0,
                    value2: detailDrinkMemory.drinkPoint?[1] ?? 0,
                    value3: detailDrinkMemory.drinkPoint?[2] ?? 0,
                    value4: detailDrinkMemory.drinkPoint?[3] ?? 0,
                    value5: detailDrinkMemory.drinkPoint?[4] ?? 0,
                    value6: detailDrinkMemory.drinkPoint?[5] ?? 0
                ), drinkCategory: drinkCategoryModel.drinkCategoryStringToType()
        )

        drinkImageView.image = drinkImageModel.getImageData(imageUUID: detailDrinkMemory.uuidString)
    }
}
