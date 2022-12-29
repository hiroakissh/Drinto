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
    func drinkMemory(forRow row: Int) -> DrinkMemorySwiftModel?
    func viewDidLoad()
    func getDrinkMemoryInCategory(_ category: String) -> [DrinkMemorySwiftModel]
    func didSelectRowAt(_ indexPath: IndexPath)
    func selectFuture(_ drink: DrinkMemorySwiftModel) -> DrinkFuture
}

protocol DrinkMemoryPresenterOutput {
    func didFetch(_ drinkMemory: [DrinkMemorySwiftModel])
}

enum DrinkFuture {
    case aroma
    case sweet
    case umami
    case astringency
    case kokou
    case coast
    case none
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
        drinkEachCategory.count
    }

    func drinkMemory(forRow row: Int) -> DrinkMemorySwiftModel? {
        let drinkMemory = model.readDrinkMemoryData()
        let indexDrinkMemory = drinkMemory[row]
        return indexDrinkMemory
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
    }

    func selectFuture(_ drink: DrinkMemorySwiftModel) -> DrinkFuture {
        let maxPoint = drink.drinkPoint?.max()
        guard let maxPoint = maxPoint else {
            return DrinkFuture.none
        }
        let firstIndex = drink.drinkPoint?.firstIndex(of: maxPoint)
        print(drink.drinkPoint?.firstIndex(of: maxPoint))
        switch firstIndex {
        case 0:
            return DrinkFuture.aroma
        case 1:
            return DrinkFuture.sweet
        case 2:
            return DrinkFuture.umami
        case 3:
            return DrinkFuture.astringency
        case 4:
            return DrinkFuture.kokou
        case 5:
            return DrinkFuture.coast
        default:
            return DrinkFuture.none
        }
    }

    func viewDidLoad() {
        drinkMemory = model.readDrinkMemoryData()
    }

    func getDrinkMemoryInCategory(_ category: String) -> [DrinkMemorySwiftModel] {
        drinkEachCategory = model.readDrinkMemoryDataInCategory(category)
        return drinkEachCategory
    }
}
