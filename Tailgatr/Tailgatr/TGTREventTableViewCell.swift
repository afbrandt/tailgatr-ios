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
    @IBOutlet weak var containerView: UIView!
    
    var event: TGTREvent!
    var userLocation: CLLocation!
    let webService = TGTRWebService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare() {
        
        containerView.layer.borderColor = UIColor.lightGrayColor().CGColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 3.0
        
        if event.distance < 0 {
            webService.getTravelTimeFromCoordinate(userLocation.coordinate, toCoordinate: event.location) {
                (success, time) -> (Void) in
                if (success) {
                    print("fetched time")
                    self.event.distance = time
                    self.transportationTimeLabel.text = "\(time)"
                } else {
                    print("did not fetch time")
                    self.transportationTimeLabel.text = "??"
                }
            }
        }
        
        if let urlString = event.imageURLLow, let url = NSURL(string: urlString) {
            webService.getImageFromURL(url, callback: { (success, image) -> (Void) in
                if (success) {
                    print("fetched image")
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .ScaleAspectFill
                    imageView.frame = self.imageContainer.bounds
//                    imageView.center = self.imageContainer.center
                    self.imageContainer.addSubview(imageView)
                } else {
                    print("didn't fetch image")
                    
                }
            })
        }
        
//        let r = Double(rand() % Int32(255))
//        let g = Double(rand() % Int32(255))
//        let b = Double(rand() % Int32(255))
//        let color = UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
//        self.backgroundColor = color
    }
}
