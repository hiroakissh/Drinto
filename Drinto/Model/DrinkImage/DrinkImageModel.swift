//
//  DrinkImageModel.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/12/11.
//

import Foundation
import UIKit

class DrinkImageModel {
    // DocumentFileのディレクトリ取得
    func getFileURL(fileName: String) -> URL {
        let documentDir = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        return documentDir.appendingPathComponent(fileName)
    }

    // Imageデータの取得
    func getImageData(imageUUID: String) -> UIImage? {
        let url = getFileURL(fileName: "\(imageUUID).jpg")
        if FileManager.default.fileExists(atPath: url.path) {
            return UIImage(contentsOfFile: url.path)
        } else {
            return nil
        }
    }

    // 画像のデータ保存
    func saveImageData(imageUUID: String, drinkImage: UIImage?) {
        guard let imageData = drinkImage?.jpegData(
            compressionQuality: 1.0) else { return }
        let imageFileURL = getFileURL(fileName: "\(imageUUID).jpg")
        do {
            try imageData.write(to: imageFileURL)
            print("image saved.")
        } catch {
            print("Failed to save the image: ", error)
        }
    }
}
