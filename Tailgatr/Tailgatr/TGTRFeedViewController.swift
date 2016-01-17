//
//  TGTRFeedViewController.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import UIKit
import MapKit

class TGTRFeedViewController: UITableViewController {
    
    var events: [TGTREvent] = []
    var hasLocationPermission = false
    var isFetchingEvents = false
    var didFetchEvents = false
    
    let webService = TGTRWebService()
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation!
    
    let cellIdentifier = "EventCell"
    let DETAIL_SEGUE = "toDetailView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let location = CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DETAIL_SEGUE {
            if let vc = segue.destinationViewController as? TGTRDetailViewController, let path = self.tableView.indexPathForSelectedRow {
                let event = events[path.row]
                vc.event = event
            }
        }
    }
    
    func fetchEventsForLocation(location: CLLocationCoordinate2D) {
        isFetchingEvents = true
        
        webService.getEventsWithLocation(location) {
            (success: Bool, events: [TGTREvent]) in
            
//            self.events = [TGTREvent()]
//            self.tableView.reloadData()
            
            self.isFetchingEvents = false
            self.didFetchEvents = true
            if success {
                print("fetched \(events.count) events")
                self.events = events
                self.tableView.reloadData()
            } else {
                print("did fail")
                
            }
        }
    }
    
    func updateLocationPermission(hasPermission: Bool) {
        if (hasPermission) {
        
        } else {
        
        }
        
        hasLocationPermission = hasPermission
    }
}

extension TGTRFeedViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
//        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! TGTREventTableViewCell?
        
        if cell == nil {
            let nibs = NSBundle.mainBundle().loadNibNamed("TGTREventTableViewCell", owner: self, options: nil)
            cell = nibs[0] as? TGTREventTableViewCell
        }
        
        cell!.event = events[indexPath.row]
        cell!.userLocation = self.lastLocation
        cell!.prepare()
        
        return cell!
    }
    
}

extension TGTRFeedViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 240.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(DETAIL_SEGUE, sender: self)
    }
}

extension TGTRFeedViewController: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
            case .AuthorizedWhenInUse:
                self.updateLocationPermission(true)
                break;
            case .Denied:
                self.updateLocationPermission(false)
                break;
            default:
                print("can't determine permission")
                break;
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !isFetchingEvents && !didFetchEvents {
            if let location = locations.first {
                self.fetchEventsForLocation(location.coordinate)
                self.lastLocation = location
            }
        }
    }
}

