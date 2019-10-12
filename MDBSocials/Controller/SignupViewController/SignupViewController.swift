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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "AppBackground")!)
        registerButton.roundedButton()
        // Do any additional setup after loading the view.
    }
    @IBAction func signup(_ sender: Any) {
        handleRegister()
    }
    
    func handleRegister() {
        registerButton.isUserInteractionEnabled = false

        var name = ""
        var username = ""
        var email = ""
        var password = ""
        name = fullNameText.text!
        if name == "" {
            self.displayAlert(title: "Missing name", message: "Enter your name.")
            return
        }
        username = userNameText.text!
        if username == "" {
            self.displayAlert(title: "Missing username", message: "Enter your username.")
            return
        }
        email = emailText.text!
        if email == "" {
            self.displayAlert(title: "Missing email", message: "Enter a valid email.")
            return
        }
        password = passwordText.text!
        if password == "" {
            self.displayAlert(title: "Missing password", message: "Enter your password.")
            return
        }
    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                self.registerButton.isUserInteractionEnabled = true
                print(error)
                self.displayAlert(title: "There was an error", message: "Trying to make you")
                return
            } else {
                
                guard let uid = user?.user.uid else {
                    return
                }
                let ref = Database.database().reference()
                let userRef = ref.child("users").child(uid)
                let values = ["name": name, "username": username, "email": email]
                
                userRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error)
                        return
                    } else {
                        self.ourUserId = user?.user.uid
                        self.performSegue(withIdentifier: "fromSignUpToFeed", sender: self)
                    }
                })
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
