//
//  DrinkMemoryPresenter.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/09.
//

import Foundation

protocol DrinkMemoryPresenterInput {
    var numberOfDrinkMemory: Int { get }
    var numberOfDrinkMemoryInCategory: Int { get }
    func drinkMemory(forRow row: Int, categoryType: CategoryType, category: String) -> DrinkMemorySwiftModel?
    func viewDidLoad()
    func getDrinkMemoryInCategory(_ category: String)
    func didSelectRowAt(_ indexPath: IndexPath)
    func selectFuture(_ drink: DrinkMemorySwiftModel) -> DrinkFuture
}

protocol DrinkMemoryPresenterOutput {
    func didFetch(_ drinkMemory: [DrinkMemorySwiftModel])
}

class DrinkMemoryPresenter: DrinkMemoryPresenterInput {

    var drinkMemory = [DrinkMemorySwiftModel]()
    var drinkEachCategory = [DrinkMemorySwiftModel]()

    var view: DrinkMemoryPresenterOutput?
    var model: DrinkMemoryRepository

    init (with view: DrinkMemoryPresenterOutput) {
        self.view = view
        self.model = DrinkMemoryRepository()
    }

    var numberOfDrinkMemory: Int {
        drinkMemory.count
    }

    var numberOfDrinkMemoryInCategory: Int {
        return drinkEachCategory.count
    }

    func drinkMemory(forRow row: Int, categoryType: CategoryType, category: String) -> DrinkMemorySwiftModel? {
        switch categoryType {
        case .all:
            drinkMemory = model.readDrinkMemoryData()
            
            let indexDrinkMemory = drinkMemory[row]
            return indexDrinkMemory
        case .category:
            drinkEachCategory = model.readDrinkMemoryDataInCategory(category)
            let indexDrinkMemory = drinkEachCategory[row]
            return indexDrinkMemory
        }
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
    }

    func selectFuture(_ drink: DrinkMemorySwiftModel) -> DrinkFuture {
        let drinkFeatureCheckModel = DrinkFeatureCheckModel(checkDrinkModel: drink)
        return drinkFeatureCheckModel.selectFeature()
    }

    func viewDidLoad() {
        drinkMemory = model.readDrinkMemoryData()
    }

    func getDrinkMemoryInCategory(_ category: String){
        drinkEachCategory = model.readDrinkMemoryDataInCategory(category)
    }
}
