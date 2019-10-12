//
//  DetailViewControllerUI.swift
//  MDBSocials
//
//  Created by shaina on 10/11/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

extension DetailViewController {
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
