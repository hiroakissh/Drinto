//
//  DrinkMemeoryViewModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/05/03.
//

import Foundation
import RxSwift
import RxRelay

enum CategoryType: Int {
    case all
    case coffee
    case blackTea
    case greenTea
    case chineseTea
    case other

    init?(selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            self = .all
        case 1:
            self = .coffee
        case 2:
            self = .blackTea
        case 3:
            self = .greenTea
        case 4:
            self = .chineseTea
        case 5:
            self = .other
        default:
            return nil
        }
    }
}

protocol DrinkMemoryViewModelProtocol {
    var items: Observable<[DrinkMemorySwiftModel]> { get }
    var selectSegmentControlIndex: BehaviorRelay<Int> { get }
    var refresh: PublishRelay<Void> { get }
    var currentItems: [DrinkMemorySwiftModel] { get }
}

class DrinkMemoryViewModel: DrinkMemoryViewModelProtocol {
    var currentItems: [DrinkMemorySwiftModel] {
        _items.value
    }
    var filteringItems: [DrinkMemorySwiftModel] = []
    var selectSegmentControlIndex = BehaviorRelay<Int>(value: 0)
    var items: RxSwift.Observable<[DrinkMemorySwiftModel]> {
        _items.asObservable()
    }
    let refresh = PublishRelay<Void>()

    private let disposeBag = DisposeBag()
    private var _items = BehaviorRelay<[DrinkMemorySwiftModel]>(value: [])
    private let drinkMemoryModel: DrinkMemoryModelProtocol

    init(drinkMemoryModel: DrinkMemoryModelProtocol = DrinkMemoryModel()) {
        self.drinkMemoryModel = drinkMemoryModel
        refresh
            .flatMap {
                drinkMemoryModel.getDrinkMemoryData().map { items in
                    items.filter { data in
                        guard let dataCategory = CategoryType(selectedIndex: self.selectSegmentControlIndex.value),
                              let selectDataCategory = data.category
                        else { return false }
                        return self.categorySwitch(
                            category: dataCategory,
                            itemCategory: selectDataCategory
                        )
                    }
                }
            }
            .bind(to: _items)
            .disposed(by: disposeBag)
    }

    func categorySwitch(category: CategoryType, itemCategory: String) -> Bool {
        print(category)
        print(itemCategory)
        switch category {
        case .all:
            return true
        case .coffee:
            return itemCategory == "コーヒー"
        case .blackTea:
            return itemCategory == "紅茶"
        case .greenTea:
            return itemCategory == "日本茶"
        case .chineseTea:
            return itemCategory == "中国茶"
        case .other:
            return itemCategory == "その他"
        }
    }
}
