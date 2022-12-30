//
//  DrinkFeatureCheckModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/12/30.
//

import Foundation

enum DrinkFuture {
    case aroma
    case sweet
    case umami
    case astringency
    case kokou
    case coast
    case balance
    case perfect
    case none
}

class DrinkFeatureCheckModel {
    var checkDrinkModel: DrinkMemorySwiftModel?

    init(checkDrinkModel: DrinkMemorySwiftModel) {
        self.checkDrinkModel = checkDrinkModel
    }

    func selectFeature() -> DrinkFuture {
        guard let checkDrinkModel = checkDrinkModel else { return DrinkFuture.none }
        guard let drinkPoints = checkDrinkModel.drinkPoint else { return DrinkFuture.none }
        guard let maxPoint = drinkPoints.max() else { return DrinkFuture.none }
        let firstIndex = drinkPoints.firstIndex(of: maxPoint)
        let featurePoints: [Int] = drinkPoints.map { $0 }
        let featurePoint: Int = featurePoints.reduce(0, +) / 5
        if featurePoint == 5 {
            return .perfect
        }

        print(featurePoint)
        switch firstIndex {
        case 0:
            return .aroma
        case 1:
            return .sweet
        case 2:
            return .umami
        case 3:
            return .astringency
        case 4:
            return .kokou
        case 5:
            return .coast
        default:
            return .none
        }
    }
}
