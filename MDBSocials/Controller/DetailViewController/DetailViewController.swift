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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToFeed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToFeedFromDetails", sender: self)
    }
    
    func setUpDetails() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "AppBackground")!)
        interestedButton.roundedButton()
        backButton.roundedButton()
        eventNameText.text = selectedEvent.eventName
        rsvpText.text = "RSVP Count: " + String(selectedEvent.numInterested)
        eventMemberText.text = "Created By: " + selectedEvent.creator
        eventDetailsText.text = selectedEvent.eventDescription
    }
    
    
}
