//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by shaina on 9/28/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NewSocialViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var event: UIImage!
    
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var datePicked: UIDatePicker!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var eventNameText: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var createEventButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logicSetup()
        setupUI()
    }
    
    @IBAction func createEvent(_ sender: Any) {
        createEventGivenFields()
    }
    @IBAction func selectImage(_ sender: Any) {
        
    }
}
