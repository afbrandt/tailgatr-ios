//
//  TGTRDetailScrollView.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import UIKit
import MapKit

class TGTRDetailScrollView: UIView {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headerImage: UIImageView!
    
    var event: TGTREvent!
    
    func prepare() {
        
        let location = event.location
        let regionSize: CLLocationDistance = 500
        
        let region = MKCoordinateRegionMakeWithDistance(location, regionSize, regionSize);
        mapView.setRegion(region, animated: false)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        mapView.addAnnotation(pin)
        
    }
}
