//
//  LoginViewControllerLogic.swift
//  MDBSocials
//
//  Created by shaina on 10/11/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
extension LoginViewController {
    func handleLogin() {
        loginButton.isUserInteractionEnabled = false
        var userName = ""
        var pw = ""
        userName = username.text!
        if userName == "" {
            self.displayAlert(title: "Missing/Invalid email", message: "Enter an email.")
            return
        }
        pw = password.text!
        if pw == "" {
            self.displayAlert(title: "Missing/Invalid password", message: "Enter a password.")
            return
        }
        
        Auth.auth().signIn(withEmail: userName, password: pw, completion: { (user, error) in
            if let error = error {
                self.loginButton.isUserInteractionEnabled = true
                print(error)
                self.displayAlert(title: "There was an error", message: "Trying to sign you in")
                return
            } else {
                self.ourUserID = user?.user.uid
                self.performSegue(withIdentifier: "toFeedView", sender: self)
            }
        })
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}
