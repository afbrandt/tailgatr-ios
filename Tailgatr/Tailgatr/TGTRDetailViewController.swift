//
//  TGTRDetailViewController.swift
//  Tailgatr
//
//  Created by Andrew Brandt on 1/16/16.
//  Copyright © 2016 TeamTailgatr. All rights reserved.
//

import UIKit

class TGTRDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var event: TGTREvent!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let width = UIScreen.mainScreen().bounds.size.width
        
        if let event = event {
            let arr = NSBundle.mainBundle().loadNibNamed("TGTRDetailScrollView", owner: self, options: nil)
            if let scrollContent = arr.first as? TGTRDetailScrollView {
                scrollContent.event = event
                scrollContent.frame = CGRectMake(0, 0, width, scrollContent.frame.size.height)
                scrollContent.prepare()
                scrollView.contentSize = scrollContent.frame.size
                scrollView.addSubview(scrollContent)
            }
        }
    }
}
