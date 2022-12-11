//
//  DrintoTests.swift
//  DrintoTests
//
//  Created by HiroakiSaito on 2022/12/11.
//

import XCTest
import RealmSwift
@testable import Drinto

final class DrintoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetArticles() {
        let fetchDrinkNewsData = FetchDrinkNewsData()
        let exp: XCTestExpectation = expectation(description: "wait for finish")
        fetchDrinkNewsData.fetchDrinkNewsData { result in
            switch result {
            case .failure(let error):
                print("error")
                print(error)
            case .success(let loadedNewsData):
                print("Succes")
                print(loadedNewsData)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5)
    }
}
