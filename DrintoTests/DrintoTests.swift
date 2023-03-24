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

    var fetchYoutubeData: MockFetchDataModelInput!

    override class func setUp() {
        self.fetchYoutubeData = MockFetchDataModelInput()
    }

    override func tearDown() {
        self.fetchYoutubeData = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

    }

    var youtubeDatas = [YoutubeDataModel]()
    func testSuccessFetchYoutubeData() async throws {

        do {
            try await self.youtubeDatas = fetchYoutubeData.fetchYoutubeData(searchTitle: "コーヒー")
            print(self.youtubeDatas)
            print("do")
            XCTAssertEqual(self.youtubeDatas.count, 20, "not get 50items")
        }
            throw APIClientError.noData
        }

    func testFetchYoutubeData() async {
        var mock = MockFetchDataModelInput()
        do {
            mock.youtubeDataModels = try await  mock.fetchYoutubeData(searchTitle: "コーヒー")
            XCTAssertEqual(mock.youtubeDataModels.count, 5)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MockFetchDataModelInput: FetchDataModelInput {
    var youtubeDataModels = [YoutubeDataModel] ()
    func fetchYoutubeData(searchTitle: String) async throws -> [Drinto.YoutubeDataModel] {
        return youtubeDataModels
    }
}
