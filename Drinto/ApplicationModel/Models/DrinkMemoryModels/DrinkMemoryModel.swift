//
//  DrinkMemoryModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/05/04.
//

import Foundation
import RxSwift
import RxRelay

protocol DrinkMemoryModelProtocol: AnyObject {
    func getDrinkMemoryData() -> Observable<[DrinkMemorySwiftModel]>
}

class DrinkMemoryMockModel: DrinkMemoryModelProtocol {
    func getDrinkMemoryData() -> RxSwift.Observable<[DrinkMemorySwiftModel]> {
        .just([])
    }
}

class DrinkMemoryModel: DrinkMemoryModelProtocol {
    func getDrinkMemoryData() -> RxSwift.Observable<[DrinkMemorySwiftModel]> {
        return Observable<[DrinkMemorySwiftModel]>
            .create { observer in
                do {
                    // TODO: Repositoryクラスとかの配置でデータ取得
                    let items = DrinkMemoryRepository1().readDrinkMemoryData()
                    observer.onNext(items)
                } catch {
                    observer.onError(error)
                }
                return Disposables.create()
            }
    }
}
