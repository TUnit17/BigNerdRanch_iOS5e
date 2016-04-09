//
//  TimeViewController.swift
//  Homepwner
//
//  Created by Ivan Cai on 3/9/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController{
    @IBOutlet var timeSelector: UIDatePicker!
    var item: Item!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        timeSelector.date = item.dateCreated
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = timeSelector.date
    }
}
