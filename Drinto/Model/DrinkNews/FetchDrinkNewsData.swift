//
//  FetchDrinkNewsData.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/04.
//

import Foundation

protocol NewsAPIDataModelInput {
    func fetchDrinkNewsData(completion: @escaping((Result<[Article], Error>) -> Void))
}

class FetchDrinkNewsData: NewsAPIDataModelInput {
    let apiKey = "84b4753e4e64481280f134d01ddfe9af"
    let urlHead = "https://newsapi.org/v2/everything?"
    let sort = "popularity"
    var category = "tea"

    func getNewsFromNewsAPI(completion: @escaping(NewsData) -> Void) {
        let newsURLString = "\(urlHead)q=\(category)&apiKey=\(apiKey)"
        print(newsURLString)
        guard let url = URL(string: newsURLString) else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: urlRequest) { data, _, error in
            if error != nil {
                print("Error")
                print(error.debugDescription)
            }
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let jsonDecoderData = try jsonDecoder.decode(NewsData.self, from: data)
                    completion(jsonDecoderData)
                } catch {
                    print("Decode Error")
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    func fetchDrinkNewsData(completion: @escaping ((Result<[Article], Error>) -> Void)) {
        let newsURLString = "\(urlHead)q=\(category)&apiKey=\(apiKey)"
        print(newsURLString)
        guard let url = URL(string: newsURLString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            let jsonDecoder = JSONDecoder()
            guard let data = data, let decodedData = try? jsonDecoder.decode(NewsData.self, from: data) else {
                let error = NSError(domain: "parse-error", code: 1, userInfo: nil)
                completion(.failure(error))
                return
            }
            completion(.success(decodedData.articles))
        }
        task.resume()
    }
}
