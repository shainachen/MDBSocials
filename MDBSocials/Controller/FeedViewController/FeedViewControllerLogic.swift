//
//  FeedViewControllerLogic.swift
//  MDBSocials
//
//  Created by shaina on 10/11/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension FeedViewController {
    func setUpTable() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    func addNewEvent() {
        let eventRef = Database.database().reference().child("events")
        eventRef.observe(.childAdded, with: { (snapshot) in
            let newEvent = snapshot.value as? [String:Any] ?? [:]
            let myEvent = Event(name: snapshot.key, event: newEvent)
            self.events.append(myEvent)
            print("events count in add new:",
                  self.events.count)
            self.events.sort(by: {$0.dateSelected > $1.dateSelected})
            self.feedTableView.reloadData()
        })
    }
    func updateEvents() {
        let eventRef = Database.database().reference().child("events")
        
        eventRef.observe(DataEventType.childChanged, with: { (snapshot) in
            let updatedEvent = snapshot.value as? [String:Any] ?? [:]
            let myEvent = Event(name: snapshot.key, event: updatedEvent)
            let updatedIndex = self.events.firstIndex(where: {$0.eventName == myEvent.eventName})
            self.events![updatedIndex!] = myEvent
            self.feedTableView.reloadData()
        })
    }
    
    func fetchData() {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let eventDic = snapshot.value as? [String:Any] ?? [:]
            var eventCollection: [Event] = []
            
            for (key, value) in eventDic {
                let currentEvent = Event(name: key, event: value as! [String : Any])
                eventCollection.append(currentEvent)
                self.feedTableView.reloadData()
            }
            self.events = eventCollection.sorted(by: { $0.dateSelected > $1.dateSelected })
            self.feedTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("events count,", String(events.count))
        return events.count
    }
    
    /// Set image and text in every cell of table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableCell") as? FeedTableViewCell {
            print("updating cell")
            let myEvent = events[indexPath.row]
            //           guard let myURL = URL(string: myEvent.) else {
            //                return cell
            //            }
            cell.eventNameText.text = myEvent.eventName
            cell.posterNameText.text = "Created by: " + myEvent.creator
            cell.numberInterested.text = "RSVP: " + String(myEvent.numInterested)
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "AppBackground")!)
            return cell
        }
        return UITableViewCell()
    }
    
    /// Set height of every row in table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    /// If row is selected, save the selected pokemon in a variable
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = events[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    func findEvent(name: String) -> Event {
        for singleEvent in events {
            if singleEvent.eventName == name {
                return singleEvent
            }
        }
        return events[0]
    }

}
