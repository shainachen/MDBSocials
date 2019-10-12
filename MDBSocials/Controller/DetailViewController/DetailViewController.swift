//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by shaina on 9/28/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    var selectedEvent: Event!
    @IBOutlet weak var eventDetailsText: UILabel!
    @IBOutlet weak var rsvpText: UILabel!
    @IBOutlet weak var interestedButton: UIButton!
    @IBOutlet weak var eventMemberText: UILabel!
    @IBOutlet weak var eventNameText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetails()
    }
    
    @IBAction func backToFeed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToFeedFromDetails", sender: self)
    }
}
