//
//  DrinkImageModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/12/11.
//

import Foundation

class DrinkImageModel {
    // DocumentFileのディレクトリ取得
    func getFileURL(fileName: String) -> URL {
        let documentDir = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        return documentDir.appendingPathComponent(fileName)
    }
}
