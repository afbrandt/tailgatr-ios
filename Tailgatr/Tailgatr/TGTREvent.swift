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
    var imageURLLow: String!
    var imageURLHigh: String!
    var tags: [String] = []
    var rating: Int = 0
    var distance = -1

    static func eventWithDictionary(dictionary: NSDictionary) -> TGTREvent {
        var event = TGTREvent()
        
        if let tags = dictionary["tags"] as? [String] {
            print("\(tags)")
        }
        
        if let lat = dictionary["lat"]?.doubleValue, let lng = dictionary["lng"]?.doubleValue {
            let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
            event.location = coord
        }
        
        if let arr = dictionary["images"] as? NSArray, let images = arr[0] as? NSDictionary, let urlLow = images["lowResUrl"] as? String, let urlHigh = images["highResUrl"] as? String {
            event.imageURLLow = urlLow
            event.imageURLHigh = urlHigh
        }
        
//        if let location = dictionary["location"] as? NSDictionary {
//            let lat = location["latitude"]?.doubleValue
//            let lng = location["longitude"]?.doubleValue
//            if let lat = lat, let lng = lng {
//                let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
//                event.location = coord
//            }
//        }
//        
        return event
    }
}
