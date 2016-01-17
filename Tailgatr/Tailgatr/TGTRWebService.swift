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
    
    let BASE_URL = "http://www.q-apps.io"
    let FEED_ENDPOINT = "/newLocation"
    
    let CITYMAPPER_URL = "https://developer.citymapper.com/api/1/traveltime/"
    
    init() {
        session = NSURLSession.sharedSession()
    }
    
    func getEventsWithLocation(location: CLLocationCoordinate2D, callback: (success: Bool, events: [TGTREvent]) -> (Void)) {
//        let events = []
//        let success = false
//        let url = NSURL(string: "\(BASE_URL)\(FEED_ENDPOINT)?lat=\(location.latitude)&lng=\(location.longitude)&dist=1")
        let url = NSURL(string: "\(BASE_URL)\(FEED_ENDPOINT)")
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
                    let events = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSArray
//                    let events = dict["events"] as! NSArray
                    var arr: [TGTREvent] = []
//                    print("\(events)")
                    
                    for event in events {
                        if let event = event as? NSDictionary {
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
    
    func getTravelTimeFromCoordinate(from: CLLocationCoordinate2D, toCoordinate to:CLLocationCoordinate2D, callback: (success: Bool, time: Int) -> (Void)) {
        let key = "girlsintech2016"
        let url = NSURL(string: "\(CITYMAPPER_URL)?startcoord=\(from.latitude)%2C\(from.longitude)&endcoord=\(to.latitude)%2C\(to.longitude)&key=\(key)")
        let request = NSURLRequest(URL: url!)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            let task = self.session.dataTaskWithRequest(request, completionHandler: {
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if let error = error {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(success: false, time: -1)
                        print("error during fetch: \(error)")
                    })
                } else if let data = data{
                    let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if let time = dict["travel_time_minutes"]?.integerValue {
                            print("\(time) to travel")
                            callback(success: true, time: time)
                        }
                    })
                } else {
                    print("\(data)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(success: false, time: -1)
                    })
                }
            })
            
            task.resume()
        }
    }
    
    func getImageFromURL(url: NSURL, callback: (success: Bool, image: UIImage?) -> (Void)) {
        
        let request = NSURLRequest(URL: url)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            let task = self.session.dataTaskWithRequest(request, completionHandler: {
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if let error = error {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(success: false, image: nil)
                        print("error during fetch: \(error)")
                    })
                } else if let data = data{
                    let image = UIImage(data: data)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        if let time = dict["travel_time_minutes"]?.integerValue {
//                            print("\(time) to travel")
//                            callback(success: true, image: image)
//                        }
                        callback(success: true, image: image)
                    })
                } else {
                    print("\(data)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(success: false, image: nil)
                    })
                }
            })
            
            task.resume()
        }
    }
}
