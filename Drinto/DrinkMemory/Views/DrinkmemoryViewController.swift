//
//  DrinkmemoryViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit
import RxSwift
import RxCocoa

class DrinkMemoryViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var categorySegmentedControl: UISegmentedControl!

    private let disposeBag = DisposeBag()

// TODO: DIのことを考えて下記で起動できるようにしたい
//    private let viewModel: DrinkMemoryViewModelProtocol

//    init(viewModel: DrinkMemoryViewModelProtocol = DrinkMemoryViewModel()) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }

//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    private let viewModel = DrinkMemoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(nibName: "DrinkMemoryTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DrinkMemoryCell"
        )
        tableView.layer.cornerRadius = 10.0

        viewModel.items.subscribe(
            onNext: { [weak self] items in
                self?.tableView.reloadData()
            }
        )
        .disposed(by: disposeBag)
        setSegmentControl()
        setTableView()
        viewModel.refresh.accept(())
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.refresh.accept(())
    }

    func setSegmentControl() {
        categorySegmentedControl.rx.selectedSegmentIndex
            .bind(to: viewModel.selectSegmentControlIndex)
            .disposed(by: disposeBag)
        categorySegmentedControl.rx.controlEvent(.valueChanged)
            .subscribe { [weak self] _ in
                self?.viewModel.refresh.accept(())
            }
    }

    func setTableView() {
        viewModel.items.bind(to: tableView.rx.items) { tableView, row, element in
            // swiftlint:disable:next force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkMemoryCell") as! DrinkMemoryTableViewCell
            cell.drinkNameLabel.text = element.drinkName
            cell.categoryLabel.text = element.category
            cell.featureLabel.text = "特徴"
            if element.imagePath != nil {
                cell.drinkImageView.image = self.getImageData(imageUUID: element.uuidString)
            }
            return cell
        }
        .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe { indexPath in
                print(indexPath.row)
                let storyBoard: UIStoryboard = UIStoryboard(name: "DetailDrinkMemoryStoryboard", bundle: nil)
                if let vc = storyBoard.instantiateInitialViewController() {
                    self.present(vc, animated: true)
                }
            }
    }

    func getImageData(imageUUID: String) -> UIImage? {
        let url = getFileURL(fileName: "\(imageUUID).jpg")
        if FileManager.default.fileExists(atPath: url.path) {
            return UIImage(contentsOfFile: url.path)
        } else {
            return nil
        }
    }

    func getFileURL(fileName: String) -> URL {
        let documentDir = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        return documentDir.appendingPathComponent(fileName)
    }
}
