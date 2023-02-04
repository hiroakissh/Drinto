//
//  DrinkCategory.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/04.
//

import Foundation

enum DrinkCategory {
    case coffee
    case blackTea
    case japanTea
    case chinaTea
    case other
}

class DrinkCategoryModel {
    var drinkCategoryString: String?
    func drinkCategoryStringToType() -> DrinkCategory {
        if drinkCategoryString == "コーヒー" {
            return .coffee
        } else if drinkCategoryString == "紅茶" {
            return .blackTea
        } else if drinkCategoryString == "日本茶" {
            return .japanTea
        } else if drinkCategoryString == "中国茶" {
            return .chinaTea
        } else if drinkCategoryString == "その他" {
            return .other
        } else {
            return .other
        }
    }
}
