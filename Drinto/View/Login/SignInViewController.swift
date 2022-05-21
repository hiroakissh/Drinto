//
//  LoginViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func guestLoginAction(_ sender: Any) {
        performSegue(withIdentifier: "Login", sender: nil)
    }
}
