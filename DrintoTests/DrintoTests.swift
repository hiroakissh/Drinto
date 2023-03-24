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

    var fetchYoutubeData: FetchDataModelInput!

    override func setUp() {
        fetchYoutubeData = MockFetchDataModelInput()
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

    func testFetchYoutubeData() async {
        do {
            youtubeDatas = try await  fetchYoutubeData.fetchYoutubeData(searchTitle: "コーヒー")
            print(youtubeDatas)
            XCTAssertEqual(youtubeDatas.count, 20)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MockFetchDataModelInput: FetchDataModelInput {
    var youtubeDataModels = [YoutubeDataModel]()
    var youtubeFetchData = FetchDataModel()
    func fetchYoutubeData(searchTitle: String) async throws -> [Drinto.YoutubeDataModel] {
        return try await youtubeFetchData.fetchYoutubeData(searchTitle: searchTitle)
    }
}
