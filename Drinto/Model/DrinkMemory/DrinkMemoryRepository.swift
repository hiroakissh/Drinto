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
    func readDrinkMemoryData() -> [DrinkMemorySwiftModel] {
        let realmModel = realm.objects(DrinkMemoryRealmModel.self)
        let realmArray = Array(realmModel)
        print(realmArray)
        print(realmArray.count)
        let drinkMemory = realmArray.map { DrinkMemorySwiftModel(managedObject: $0) }
        return drinkMemory
    }

    func addDrinkMemoryData(_ drinkMemoryData: DrinkMemorySwiftModel) {
        let realmModel = DrinkMemoryRealmModel()
        let realmDrinkPoint = DrinkPoint()

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

private extension DrinkMemorySwiftModel {

    init(managedObject: DrinkMemoryRealmModel) {
        self.uuidString = managedObject.drinkMemoryUUID
        self.drinkName = managedObject.drinkName
        self.category = managedObject.category
        self.imagePath = managedObject.imagePath
        // TODO: Listを[Intに変換]
        self.drinkPoint?.append(managedObject.drinkPoint[0].value1)
        self.drinkPoint?.append(managedObject.drinkPoint[0].value2)
        self.drinkPoint?.append(managedObject.drinkPoint[0].value3)
        self.drinkPoint?.append(managedObject.drinkPoint[0].value4)
        self.drinkPoint?.append(managedObject.drinkPoint[0].value5)
        self.drinkPoint?.append(managedObject.drinkPoint[0].value6)

//        self.drinkPoint?.append(managedObject.drinkPoint)
    }

    func convertArray(_ drinkPoint: List<DrinkPoint>) {
        var array = Array<Any>()
        array.append(contentsOf: Array(drinkPoint))
        print(array)
    }

    func managedObject() -> DrinkMemoryRealmModel {
        let realmModel = DrinkMemoryRealmModel()
        let realmDrinkPoint = DrinkPoint()

        realmModel.drinkMemoryUUID = self.uuidString
        realmModel.drinkName = self.drinkName
        realmModel.category = self.category
        realmModel.imagePath = self.imagePath

        realmDrinkPoint.value1 = self.drinkPoint?[0] ?? 0
        realmDrinkPoint.value2 = self.drinkPoint?[1] ?? 0
        realmDrinkPoint.value3 = self.drinkPoint?[2] ?? 0
        realmDrinkPoint.value4 = self.drinkPoint?[3] ?? 0
        realmDrinkPoint.value5 = self.drinkPoint?[4] ?? 0
        realmDrinkPoint.value6 = self.drinkPoint?[5] ?? 0

        realmModel.drinkPoint.append(realmDrinkPoint)

        return realmModel
    }
}
