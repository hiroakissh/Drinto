//
//  DrinkNewsDetailViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/06/06.
//

import UIKit
import WebKit

class DrinkNewsDetailViewController: UIViewController {
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var navigationTitle: UINavigationItem!

    var newsData: Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let newsData = newsData else {
            return
        }
        navigationTitle.title = newsData.title
        guard let newsURL = URL(string: newsData.url) else {
            return
        }
        let newsRequest = URLRequest(url: newsURL)
        webView.load(newsRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
    @IBAction private func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
