//
//  DrinkMemorySwiftModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/13.
//

import Foundation

struct DrinkMemorySwiftModel {
    var uuid: UUID? {
        UUID(uuidString: uuidString)
    }
    var uuidString = UUID().uuidString
    var drinkName: String?
    var category: String?
    var imagePath: String?
    var drinkPoint: [Int]?
}
