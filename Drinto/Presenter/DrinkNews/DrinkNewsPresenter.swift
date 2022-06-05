//
//  DrinkNewsProtocol.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/04.
//

import Foundation

protocol DrinkNewsPresenterInput {
    var numberOfNewsData: Int { get }
    func newsData(forRow row: Int) -> Article?
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol DrinkNewsPresenterOutput {
    func didFetch(_ drinkNews: [Article])
    func didFailToFetchDrinkNews(with error: Error)
    func didPrepareInfomation(of newsData: Article)
}

class DrinkNewsPresenter: DrinkNewsPresenterInput {
    private(set) var newsData = [Article]()

    private var view: DrinkNewsPresenterOutput?
    private var newsDataModel: NewsAPIDataModelInput

    init(with view: DrinkNewsPresenterOutput) {
        self.view = view
        self.newsDataModel = FetchDrinkNewsData()
    }

    var numberOfNewsData: Int {
        return newsData.count
    }

    func newsData(forRow row: Int) -> Article? {
        if row >= newsData.count {
            return nil
        }
        return newsData[row]
    }

    func viewDidLoad() {
        newsDataModel.fetchDrinkNewsData { [weak self] result in
            switch result {
            case .failure(let error):
                self?.view?.didFailToFetchDrinkNews(with: error)
            case .success(let loadedNewsData):
                self?.newsData = loadedNewsData
                guard let newsData = self?.newsData else {
                    fatalError()
                }
                self?.view?.didFetch(newsData)
            }
        }
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let newsDataDetail = newsData(forRow: indexPath.row) else { return }
        view?.didPrepareInfomation(of: newsDataDetail)
    }
}
