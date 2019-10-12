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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "AppBackground")!)
        loginButton.roundedButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.isUserInteractionEnabled = true
    }
    
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
        
        /* PART 1A FINISH*/
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

extension UIButton{
    /// Rounds the corners of the UIButton
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight, .bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
