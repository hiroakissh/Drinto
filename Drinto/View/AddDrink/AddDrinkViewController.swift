//
//  AddDrinkViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class AddDrinkViewController: UIViewController {
    @IBOutlet private weak var value1TextField: UITextField!
    @IBOutlet private weak var value2TextField: UITextField!
    @IBOutlet private weak var value3TextField: UITextField!
    @IBOutlet private weak var value4TextField: UITextField!
    @IBOutlet private weak var value5TextField: UITextField!
    @IBOutlet private weak var value6TextField: UITextField!
    @IBOutlet private weak var drinkNameTextField: UITextField!
    @IBOutlet private weak var categoryTextField: UITextField!

    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var drinkImageView: UIImageView!

    private var pickerView = UIPickerView()
    private var editTextFiled: UITextField?

    private let point: [String] = ["0", "1", "2", "3", "4", "5"]
    private let category: [String] = ["コーヒ", "紅茶", "日本茶", "中国茶", "その他"]

    var drinkMemoryRepository = DrinkMemoryRepository()
    var drinkMemorySwiftModel = DrinkMemorySwiftModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        settingUI()
        createPickerView()
        value1TextField.delegate = self
        value2TextField.delegate = self
        value3TextField.delegate = self
        value4TextField.delegate = self
        value5TextField.delegate = self
        value6TextField.delegate = self
        categoryTextField.delegate = self
    }
    @IBAction private func addButtonAction(_ sender: Any) {
        let uuid = UUID()

        drinkMemorySwiftModel.uuidString = uuid.uuidString
        drinkMemorySwiftModel.drinkName = drinkNameTextField.text
        drinkMemorySwiftModel.category = categoryTextField.text
        drinkMemorySwiftModel.imagePath = ""

        // TODO: 0~5の間の値チェックを入れる

        let value1 = Int(value1TextField.text ?? "0") ?? 0
        let value2 = Int(value2TextField.text ?? "0") ?? 0
        let value3 = Int(value3TextField.text ?? "0") ?? 0
        let value4 = Int(value4TextField.text ?? "0") ?? 0
        let value5 = Int(value5TextField.text ?? "0") ?? 0
        let value6 = Int(value6TextField.text ?? "0") ?? 0

        drinkMemorySwiftModel.drinkPoint = [value1, value2, value3, value4, value5, value6]
        drinkMemoryRepository.addDrinkMemoryData(drinkMemorySwiftModel)
    }

    private func settingUI() {
        addButton.layer.cornerRadius = 10.0
    }
}

extension AddDrinkViewController {
    @objc func donePicker() {
        value1TextField.endEditing(true)
        value2TextField.endEditing(true)
        value3TextField.endEditing(true)
        value4TextField.endEditing(true)
        value5TextField.endEditing(true)
        value6TextField.endEditing(true)
        categoryTextField.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        value1TextField.endEditing(true)
        value2TextField.endEditing(true)
        value3TextField.endEditing(true)
        value4TextField.endEditing(true)
        value5TextField.endEditing(true)
        value6TextField.endEditing(true)
        categoryTextField.endEditing(true)
    }
}

extension AddDrinkViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if editTextFiled == categoryTextField {
            return category.count
        } else {
            return point.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if editTextFiled == categoryTextField {
            return category[row]
        } else {
            return point[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if editTextFiled == value1TextField {
            value1TextField.text = point[row]
        } else if editTextFiled == value2TextField {
            value2TextField.text = point[row]
        } else if editTextFiled == value3TextField {
            value3TextField.text = point[row]
        } else if editTextFiled == value4TextField {
            value4TextField.text = point[row]
        } else if editTextFiled == value5TextField {
            value5TextField.text = point[row]
        } else if editTextFiled == value6TextField {
            value6TextField.text = point[row]
        } else if editTextFiled == categoryTextField {
            categoryTextField.text = category[row]
        }
    }

    func createPickerView() {
        pickerView.delegate = self
        value1TextField.inputView = pickerView
        value2TextField.inputView = pickerView
        value3TextField.inputView = pickerView
        value4TextField.inputView = pickerView
        value5TextField.inputView = pickerView
        value6TextField.inputView = pickerView
        categoryTextField.inputView = pickerView

        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(AddDrinkViewController.donePicker)
        )
        toolbar.setItems([doneButtonItem], animated: true)
        value1TextField.inputAccessoryView = toolbar
        value2TextField.inputAccessoryView = toolbar
        value3TextField.inputAccessoryView = toolbar
        value4TextField.inputAccessoryView = toolbar
        value5TextField.inputAccessoryView = toolbar
        value6TextField.inputAccessoryView = toolbar
        categoryTextField.inputAccessoryView = toolbar
    }
}

extension AddDrinkViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        editTextFiled = textField
        return true
    }
}
