//
//  FeedViewController.swift
//  MDBSocials
//
//  Created by shaina on 9/28/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var feedTableView: UITableView!
    
    var events: [Event]! = []
    var selectedEvent: Event!
    
    let ref = Database.database().reference().child("events")
    
    override func viewWillAppear(_ animated: Bool) {
        feedTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        addNewEvent()
        updateEvents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            if let dest = segue.destination as? DetailViewController {
                dest.selectedEvent = selectedEvent
            }
        }
    }
}
