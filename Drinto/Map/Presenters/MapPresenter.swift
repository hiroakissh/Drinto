//
//  MapPresenter.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/04/16.
//

import Foundation

protocol MapPresenterInput {
    func fetchLocationData() -> [Any]
}

protocol MapPresenterOutput {

}

class MapPresenter: MapPresenterInput {
    func fetchLocationData() -> [Any] {
        // 仮置き
        return []
    }
}
