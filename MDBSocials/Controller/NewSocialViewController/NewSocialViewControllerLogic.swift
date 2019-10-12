//
//  NewSocialViewControllerLogic.swift
//  MDBSocials
//
//  Created by shaina on 10/11/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension NewSocialViewController {
    func logicSetup() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.displayAlert(title: "No camera detected", message: "Could not locate camera to use.")
        }else {
            self.cameraSetup()
        }
    }
    
    func cameraSetup() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.cameraDevice
            = .front
        self.present(picker, animated: false, completion: nil)
    }
    
    func createEventGivenFields() {
        var name = ""
        var description = ""
        var date: Date
        name = eventNameText.text!
        if name == "" {
            self.displayAlert(title: "Missing event name", message: "Enter your event name.")
            return
        }
        description = descriptionText.text!
        if description == "" {
            self.displayAlert(title: "Missing description", message: "Enter a description.")
            return
        }
        date = datePicked.date
        print("finished setting all data")
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(currentUser.uid)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userName = value?["name"] as? String ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            let strDate = dateFormatter.string(from: date)
            let strNumInterested = String(0)
            let values = ["creator": userName, "description": description, "date": strDate, "interest": strNumInterested]
            
            print("done creating vaules")
            ref.child("events").child(name).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error)
                    return
                } else {
                    print("successfully created event")
                    self.performSegue(withIdentifier: "backToFeedView"
                        , sender: self)
                }
            })
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let info = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let optimizedImageData = info.jpegData(compressionQuality: 0.6) {
            self.event = info
            uploadProfileImage(imageData: optimizedImageData)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileImage(imageData: Data)
    {
        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        
        let storageReference = Storage.storage().reference()
        let currentUser = Auth.auth().currentUser
        let storageLocation = currentUser!.uid + "-" + eventNameText.text! + ".jpg"
        let profileImageRef = storageReference.child("users").child(currentUser!.uid).child(storageLocation)
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        profileImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if error != nil
            {
                print("Error took place \(String(describing: error?.localizedDescription))")
                return
            } else {
                self.eventImgView.image = UIImage(data: imageData)
                print("Meta data of uploaded image \(String(describing: uploadedImageMeta))")
            }
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}
