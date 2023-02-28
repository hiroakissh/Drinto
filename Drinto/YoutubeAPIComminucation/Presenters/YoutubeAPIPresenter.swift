//
//  YoutubeAPIPresenter.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/02/20.
//

import Foundation

class YoutubeAPIPresenter {
//    func getTimeLine() async throws -> String {
//        let requestUrlString = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=@Saito1014&count=10"
//
//        guard let url = URLComponents(string: requestUrlString) else {
//            fatalError("NoURL")
//        }
//
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url.url!)
//            guard let httpStatus = response as? HTTPURLResponse else {
//                throw fatalError("statusNo")
//            }
//
//            switch httpStatus.statusCode {
//            case 200 ..< 400:
//                guard let response = String(data: data, encoding: .utf8) else {
//                    throw fatalError("noData")
//                }
//                return response
//            case 400...:
//                throw fatalError("badStatusCode")
//            default:
//                fatalError("予期せぬStatusCode")
//                break
//            }
//        } catch {
//            throw fatalError("serverError")
//        }
//    }

    func getTimeLine() {
        print("3")
        let requestUrlString = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=@Saito1014&count=10"
        let bearerToken = "AAAAAAAAAAAAAAAAAAAAACd6lwEAAAAA8iJIliecq%2B7F0UPaGvHmERhUp8M%3DzWEAThZsvJ1gi2tfPkoL2iJzh1PZHQDJLqF2m20Cc9Dw3JMt1q"

        let headers = ["Authorization": bearerToken]

        let url = URL(string: requestUrlString)
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers
        
        print("5")
        guard let url = URLComponents(string: requestUrlString) else {
            fatalError("NoURL")
        }
        print("6")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            guard let response = response else { return }
            do {
                print(data)
                print(response)
            } catch let error {
                print(error)
            }
        }
        print("7")
    }
}
