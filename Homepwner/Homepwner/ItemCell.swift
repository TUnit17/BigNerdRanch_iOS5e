//
//  ItemCell.swift
//  Homepwner
//
//  Created by Ivan Cai on 2/23/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell{
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel:  UILabel!
    func updateLabels(){
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        serialNumberLabel.font = caption1Font
    }
}
