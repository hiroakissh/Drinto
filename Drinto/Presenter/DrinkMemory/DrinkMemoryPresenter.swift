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
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol DrinkMemoryPresenterOutput {
    func didFetch(_ drinkMemory: [DrinkMemorySwiftModel])
}

class DrinkMemoryPresenter {

}
