//
//  DrinkMemoryRepository.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/09.
//

import Foundation
import RealmSwift

protocol DrinkMemorySwiftModelInput {
//    func fetchDrinkMemoryData(completion: @escaping((Result<[DrinkMemorySwiftModel], Error>) -> Void))
    func addDrinkMemoryData(_ drinkMemoryData: DrinkMemorySwiftModel)
    func removeDrinkMemoryData(at index: Int)
    func updateDrinkMemoryData(at index: Int)
}

class DrinkMemoryRepository: DrinkMemorySwiftModelInput {
    // swiftlint:disable:next force_try
    private let realm = try! Realm()

//    func fetchDrinkMemoryData(completion: @escaping ((Result<[DrinkMemorySwiftModel], Error>) -> Void)) {
//
//    }

    func addDrinkMemoryData(_ drinkMemoryData: DrinkMemorySwiftModel) {
        let realmModel = DrinkMemoryRealmModel()
        let realmDrinkPoint = DrinkPoint()
        let uuid = UUID()

        realmModel.drinkMemoryUUID = drinkMemoryData.uuidString
        realmModel.drinkName = drinkMemoryData.drinkName
        realmModel.category = drinkMemoryData.category
        realmModel.imagePath = drinkMemoryData.imagePath

        realmDrinkPoint.value1 = drinkMemoryData.drinkPoint?[0] ?? 0
        realmDrinkPoint.value2 = drinkMemoryData.drinkPoint?[1] ?? 0
        realmDrinkPoint.value3 = drinkMemoryData.drinkPoint?[2] ?? 0
        realmDrinkPoint.value4 = drinkMemoryData.drinkPoint?[3] ?? 0
        realmDrinkPoint.value5 = drinkMemoryData.drinkPoint?[4] ?? 0
        realmDrinkPoint.value6 = drinkMemoryData.drinkPoint?[5] ?? 0

        realmModel.drinkPoint.append(realmDrinkPoint)

        do {
            try realm.write {
                realm.add(realmModel)
            }
        } catch {
            print("Realm Add Error")
            return
        }
        print(realmModel)
    }

    func removeDrinkMemoryData(at index: Int) {
        print(index)
    }

    func updateDrinkMemoryData(at index: Int) {
        print(index)
    }
}
