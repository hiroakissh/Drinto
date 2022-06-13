//
//  DrinkMemoryModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/09.
//

import Foundation
import RealmSwift

class DrinkPoint: Object {
    @Persisted var value1: Int
    @Persisted var value2: Int
    @Persisted var value3: Int
    @Persisted var value4: Int
    @Persisted var value5: Int
    @Persisted var value6: Int
}

class DrinkMemoryRealmModel: Object {
    @Persisted var drinkMemoryUUID: String = ""
    @Persisted var drinkName: String?
    @Persisted var category: String?
    @Persisted var imagePath: String?
    var drinkPoint = List<DrinkPoint>()

    var uuid: UUID? {
        UUID(uuidString: drinkMemoryUUID)
    }

    override class func primaryKey() -> String? {
        "drinkMemoryUUID"
    }

    convenience init(drinkName: String, category: String, imagePath: String, drinkPoint: List<DrinkPoint>) {
        self.init()
        self.drinkName = drinkName
        self.category = category
        self.imagePath = imagePath
        self.drinkPoint = drinkPoint
    }
}

class DrinkMemoryRealmModelList: Object {
    let drinkMemoryRealmModelList = List<DrinkMemoryRealmModel>()
}
