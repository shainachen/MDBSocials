//
//  Event.swift
//  MDBSocials
//
//  Created by shaina on 10/11/19.
//  Copyright © 2019 shaina. All rights reserved.
//

import UIKit

class Event {
    var eventName: String
    var creator: String
    var eventDescription: String
    var dateSelected: Date
    var numInterested: Int
 //   var image: UIImage
    
    init(name: String, event: [String: Any]) {
        self.eventName = name
        
        if event["creator"] as? String == "" {
            self.creator = "Creator"
        } else {
            self.creator = event["creator"] as! String
        }
        
        if event["description"] as? String == "" {
            self.eventDescription = "Description"
        } else {
            self.eventDescription = event["description"] as! String
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        self.dateSelected = dateFormatter.date(from: event["date"] as! String)!
        
        if event["interest"] as? String == "" {
            self.numInterested = 0
        } else {
            self.numInterested = Int(event["interest"] as! String) ?? 0
        }
 //       self.image = image
    }
}
