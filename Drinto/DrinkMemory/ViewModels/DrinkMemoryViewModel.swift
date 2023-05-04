//
//  DrinkMemeoryViewModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/05/03.
//

import Foundation
import RxSwift
import RxRelay

protocol DrinkMemoryViewModelProtocol {
    var items: Observable<[DrinkMemorySwiftModel]> { get }
    var refresh: PublishRelay<Void> { get }
    var currentItems: [DrinkMemorySwiftModel] { get }
}

class DrinkMemoryViewModel: DrinkMemoryViewModelProtocol {
    var currentItems: [DrinkMemorySwiftModel] {
        _items.value
    }

    private let disposeBag = DisposeBag()

    var items: RxSwift.Observable<[DrinkMemorySwiftModel]> { _items.asObservable() }
    var refresh: RxRelay.PublishRelay<Void>

    private var _items = BehaviorRelay<[DrinkMemorySwiftModel]>(value: [])
    private let drink



    
}
