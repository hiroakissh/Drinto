//
//  AddDrinkViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit
import RealmSwift

class AddDrinkViewController: UIViewController {
    @IBOutlet private weak var value1TextField: UITextField!
    @IBOutlet private weak var value2TextField: UITextField!
    @IBOutlet private weak var value3TextField: UITextField!
    @IBOutlet private weak var value4TextField: UITextField!
    @IBOutlet private weak var value5TextField: UITextField!
    @IBOutlet private weak var value6TextField: UITextField!
    @IBOutlet private weak var drinkNameTextField: UITextField!
    @IBOutlet private weak var categoryTextField: UITextField!

    // swiftlint:disable force_try
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addButtonAction(_ sender: Any) {
        let realmModel = DrinkMemoryRealmModel()
        let drinkPoint = DrinkPoint()
        var drinkPointList: List<DrinkPoint>?
        let uuid = UUID()

        drinkPoint.value1 = Int(value1TextField.text ?? "0") ?? 0
        drinkPoint.value2 = Int(value2TextField.text ?? "0") ?? 0
        drinkPoint.value3 = Int(value3TextField.text ?? "0") ?? 0
        drinkPoint.value4 = Int(value4TextField.text ?? "0") ?? 0
        drinkPoint.value5 = Int(value5TextField.text ?? "0") ?? 0
        drinkPoint.value6 = Int(value6TextField.text ?? "0") ?? 0
        print(drinkPoint)

        drinkPointList?.append(drinkPoint)
        print("drinkPoint\n\(drinkPoint)")
        print("drinkPointList\n\(drinkPointList)")
        print("realm drinkPoint\n\(realmModel.drinkPoint)")

        realmModel.drinkMemoryUUID = uuid.uuidString
        realmModel.drinkName = drinkNameTextField.text
        realmModel.category = categoryTextField.text
        realmModel.imagePath = ""
        realmModel.drinkPoint.append(drinkPoint)
//        drinkPointList?.append(drinkPoint)

        realmModel.drinkPoint.append(drinkPoint)
        print(realmModel)

        do {
            try realm.write {
                realm.add(realmModel)
//                realm.add(drinkPoint)
            }
        } catch {
            print("Realm Add Error")
            return
        }
        print(realmModel)
    }

    @IBAction private func test(_ sender: Any) {
        do {
            let realmTest = try Realm()

            let results = realm.objects(DrinkMemoryRealmModel.self)
//            let resultDrinkPoint = realm.objects(DrinkPoint.self)
            print(results)
            let drinkPointList: List<DrinkPoint>?
//            print(results[0].drinkPoint)
            drinkPointList = realmTest.objects(DrinkMemoryRealmModel.self).first?.drinkPoint
            print(drinkPointList)
//            print(realm.objects(DrinkMemoryRealmModel.self).first?.drinkPoint)
//            print(resultDrinkPoint)
        }
        catch {
            print(error)
        }

    }
}
