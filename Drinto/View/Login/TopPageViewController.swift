//
//  TopPageViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class TopPageViewController: UIViewController {

    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var getSignInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingUI()
        // Do any additional setup after loading the view.
    }

    func settingUI() {
        signInButton.layer.cornerRadius = 15.0
        signUpButton.layer.cornerRadius = 15.0
    }

    @IBAction private func sigInButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "SignIn", sender: nil)
    }

    @IBAction private func signUpButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: nil)
    }

    @IBAction private func guestLoginButtonAction(_ sender: Any) {
    }
}
