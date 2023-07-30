//
//  DrinkMemoryRepository.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/05/04.
//

import Foundation
import RxSwift
import RxRelay

class DrinkMemoryRepository: RemoteRepository {

    var errorRelay = RxRelay.BehaviorRelay<Error?>(value: nil)

    var loadingRelay = RxRelay.BehaviorRelay<Bool>(value: false)

    var lastUpdated: Date?
    var disposeBag = DisposeBag()

    var localDataSource: LocalDataSource?
}

