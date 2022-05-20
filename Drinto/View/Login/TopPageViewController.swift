//
//  TopPageViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class TopPageViewController: UIViewController {

    @IBOutlet private weak var SignInButton: UIButton!
    @IBOutlet private weak var SignUpButton: UIButton!
    @IBOutlet private weak var getSignInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingUI()
        // Do any additional setup after loading the view.
    }

    func settingUI() {
        SignInButton.layer.cornerRadius = 15.0
        SignUpButton.layer.cornerRadius = 15.0
    }
}
