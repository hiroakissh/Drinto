//
//  DrinkmemoryViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class DrinkMemoryViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var categorySegmentedControl: UISegmentedControl!

    private var drinkMemory = DrinkMemoryRepository()

    private var drinkImageModel = DrinkImageModel()

    private var drinkMemoryPresenter: DrinkMemoryPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        drinkMemoryPresenter = DrinkMemoryPresenter.init(with: self)
        drinkMemoryPresenter.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: "DrinkMemoryTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DrinkMemoryCell"
        )
        tableView.layer.cornerRadius = 10.0
    }
    override func viewWillAppear(_ animated: Bool) {
        drinkMemoryPresenter.viewDidLoad()
        tableView.reloadData()
    }

    // TODO: ジャンルごとに表示の切り替わり
    @IBAction private func switchCategoryAction(_ sender: UISegmentedControl) {
        print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        var title = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        print(drinkMemoryPresenter.getDrinkMemoryInCategory(title))
        print(drinkMemoryPresenter.numberOfDrinkMemoryInCategory)
    }
}

extension DrinkMemoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkMemoryPresenter?.numberOfDrinkMemory ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexDrinkMemory = drinkMemoryPresenter.drinkMemory(forRow: indexPath.row)
        guard let indexDrinkMemory = indexDrinkMemory else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkMemoryCell", for: indexPath) as? DrinkMemoryTableViewCell
            cell?.drinkNameLabel.text = "読み込めませんでした"
            return cell!
        }

        let drinkCell = tableView.dequeueReusableCell(
            withIdentifier: "DrinkMemoryCell",
            for: indexPath
            // swiftlint:disable:next force_cast
        ) as! DrinkMemoryTableViewCell
        drinkCell.drinkNameLabel.text = indexDrinkMemory.drinkName
        drinkCell.categoryLabel.text = indexDrinkMemory.category
        let feature = drinkMemoryPresenter.selectFuture(indexDrinkMemory)
        switch feature {
        case .aroma:
            drinkCell.featureLabel.text = "香り重視"
        case .sweet:
            drinkCell.featureLabel.text = "甘味重視"
        case .umami:
            drinkCell.featureLabel.text = "旨味重視"
        case .astringency:
            drinkCell.featureLabel.text = "香重視"
        case .kokou:
            drinkCell.featureLabel.text = "香り重視"
        case .coast:
            drinkCell.featureLabel.text = "香り重視"
        case .none:
            drinkCell.featureLabel.text = "香り重視"
        }
        // TODO: Imagepathに関しての追記
        if indexDrinkMemory.imagePath != nil {
            print(drinkCell.drinkImageView.frame.width)
            print(drinkCell.drinkImageView.frame.height)
            drinkCell.drinkImageView.image = drinkImageModel.getImageData(imageUUID: indexDrinkMemory.uuidString)
        }
        return drinkCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectDrinkMemory = drinkMemory.readDrinkMemoryData()
        let selectDrinkMemory = drinkMemoryPresenter.drinkMemory(forRow: indexPath.row)
        performSegue(withIdentifier: "detailDrinkMemory", sender: selectDrinkMemory)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailDrinkMemory" {
            let detailDrinkMemoryVC = segue.destination as? DetailDrinkMemoryViewController
            guard let sender = sender else {
                return
            }
            // swiftlint:disable:next force_cast
            detailDrinkMemoryVC?.detailDrinkMemory = sender as! DrinkMemorySwiftModel
        }
    }
}

extension DrinkMemoryViewController: DrinkMemoryPresenterOutput {
    func didFetch(_ drinkMemory: [DrinkMemorySwiftModel]) {
        print("outputPresenter")
    }
}
