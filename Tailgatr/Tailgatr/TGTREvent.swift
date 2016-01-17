//
//  TGTREvent.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import MapKit

struct TGTREvent {

    var location: CLLocationCoordinate2D!
    var name: String!
    var imageURL: String!
    var tags: [String] = []
    var rating: Int = 0

    static func eventWithDictionary(dictionary: NSDictionary) -> TGTREvent {
        var event = TGTREvent()
        
        if let tags = dictionary["tags"] as? [String] {
            print("\(tags)")
        }
        
        if let location = dictionary["location"] as? NSDictionary {
            let lat = location["latitude"]?.doubleValue
            let lng = location["longitude"]?.doubleValue
            if let lat = lat, let lng = lng {
                let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
                event.location = coord
            }
        }
        
        return event
    }
}
