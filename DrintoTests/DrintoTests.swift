//
//  DrintoTests.swift
//  DrintoTests
//
//  Created by HiroakiSaito on 2022/12/11.
//

import XCTest
import RealmSwift
import FirebaseCore
@testable import Drinto

final class DrintoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    var youtubeDatas = [YoutubeDataModel]()
    func testFetchYoutubeData() {
        let fetchYoutubeData = FetchDataModel()
        Task.detached {
            do {
                try await self.youtubeDatas = fetchYoutubeData.fetchYoutubeData(searchTitle: "コーヒー")
                XCTAssertEqual(self.youtubeDatas.count, 20, "not get 50items")
            } catch {
                throw APIClientError.noData
            }
        }
    }
}
