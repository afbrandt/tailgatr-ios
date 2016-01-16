//
//  TGTRWebService.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import Foundation
import MapKit

struct TGTRWebService {
    
    var session: NSURLSession!
    
    let BASE_URL = "http://1.1.1.1/v1"
    let FEED_ENDPOINT = "/feed"
    
    init() {
        session = NSURLSession.sharedSession()
    }
    
    func getEventsWithLocation(location: CLLocationCoordinate2D, callback: (success: Bool, events: [TGTREvent]) -> (Void)) {
//        let events = []
//        let success = false
        let url = NSURL(string: "\(BASE_URL)\(FEED_ENDPOINT)?lat=\(location.latitude)&lon=\(location.longitude)")
        let request = NSURLRequest(URL: url!)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
           let task = self.session.dataTaskWithRequest(request) {
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if let error = error {
                    print("error during fetch: \(error)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(success: false, events: [])
                    })
                } else if let data = data {
                    let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                    let events = dict["events"] as! NSArray
                    var arr: [TGTREvent] = []
                    
                    for dict in events {
                        if let event = dict as? NSDictionary {
                            arr.append(TGTREvent.eventWithDictionary(event))
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(success: true, events: arr)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(success: false, events: [])
                    })
                }
            }
        
            task.resume()
        }
        
        
//        callback(success: success, events: events as! [TGTREvent])
    }
}
