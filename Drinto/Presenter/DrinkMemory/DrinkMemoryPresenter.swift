//
//  DrinkMemoryPresenter.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/09.
//

import Foundation

protocol DrinkMemoryPresenterInput {
    var numberOfDrinkMemory: Int { get }
    func drinkMemory(forRow row: Int) -> DrinkMemorySwiftModel?
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol DrinkMemoryPresenterOutput {
    func didFetch(_ drinkMemory: [DrinkMemorySwiftModel])
}

class DrinkMemoryPresenter: DrinkMemoryPresenterInput {
    var drinkMemory = [DrinkMemorySwiftModel]()

    var view: DrinkMemoryPresenterOutput?
    var model: DrinkMemoryRepository

    init (with view: DrinkMemoryPresenterOutput) {
        self.view = view
        self.model = DrinkMemoryRepository()
    }

    var numberOfDrinkMemory: Int {
        drinkMemory.count
    }

    func drinkMemory(forRow row: Int) -> DrinkMemorySwiftModel? {
        let drinkMemory = model.readDrinkMemoryData()
        let indexDrinkMemory = drinkMemory[row]
        return indexDrinkMemory
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
    }

    func viewDidLoad() {
        drinkMemory = model.readDrinkMemoryData()
    }
}
