//
//  TGTREventTableViewCell.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import UIKit

class TGTREventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var transportationTypeImage: UIImageView!
    @IBOutlet weak var transportationTimeLabel: UILabel!
    
    var event: TGTREvent!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare() {
        
        let r = Double(rand() % Int32(255))
        let g = Double(rand() % Int32(255))
        let b = Double(rand() % Int32(255))
        let color = UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
        self.backgroundColor = color
    }
}
