//
//  CachedRepository.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/05/04.
//

import Foundation
import RxSwift
import RxRelay

protocol LocalDataSource {
    func fetch() -> Single<Any>
    func store(data: Any)

    var lastUpdate: Date? { get }
}
