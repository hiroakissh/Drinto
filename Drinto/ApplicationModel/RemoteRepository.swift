//
//  RemoteRepository.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/05/04.
//

import Foundation
import RxSwift
import RxRelay

public protocol RemoteRepository: AnyObject {
    var errorRelay: BehaviorRelay<Error?> { get }
    var loadingRelay: BehaviorRelay<Bool> { get }

    var lastUpdated: Date? { get }
}
