//
//  LoginViewControllerUI.swift
//  MDBSocials
//
//  Created by shaina on 10/11/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension LoginViewController {
    func setupUI() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "AppBackground")!)
        loginButton.roundedButton()
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
