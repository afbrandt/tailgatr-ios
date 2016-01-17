//
//  TGTREventTableViewCell.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import UIKit
import MapKit

class TGTREventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var transportationTypeImage: UIImageView!
    @IBOutlet weak var transportationTimeLabel: UILabel!
    
    var event: TGTREvent!
    var userLocation: CLLocation!
    let webService = TGTRWebService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare() {
        
        webService.getTravelTimeFromCoordinate(userLocation.coordinate, toCoordinate: userLocation.coordinate) {
            (success, time) -> (Void) in
            if (success) {
                print("fetched time")
                self.transportationTimeLabel.text = "\(time) minutes away"
            } else {
                print("did not fetch time")
                self.transportationTimeLabel.text = "some minutes away"
            }
        }
        
        let r = Double(rand() % Int32(255))
        let g = Double(rand() % Int32(255))
        let b = Double(rand() % Int32(255))
        let color = UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
        self.backgroundColor = color
    }
}
