//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by shaina on 9/28/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    var ourUserID: String!
    @IBAction func loginButtonPressed(_ sender: Any) {
        handleLogin()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.isUserInteractionEnabled = true
    }
}
