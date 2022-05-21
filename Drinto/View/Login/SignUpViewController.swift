//
//  SignUpViewController.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/20.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func guestLoginAction(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: nil)
    }
}
