//
//  TGTREvent.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import MapKit

class TGTREvent: NSObject {

    var location: CLLocationCoordinate2D!
    var name: String!
    var rating: Int = 0

    static func eventWithDictionary(dictionary: NSDictionary) -> TGTREvent {
        let event = TGTREvent()
        return event
    }

}
