//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by shaina on 9/28/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var ourUserId: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func signup(_ sender: Any) {
        handleRegister()
    }
}
