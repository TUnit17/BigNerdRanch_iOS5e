//
//  Item.swift
//  Homepwner
//
//  Created by Ivan Cai on 2/13/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject, NSCoding{
    var name: String
    var valueInDollar: Int
    var serialNumber: String?
    var dateCreated: NSDate
    var itemKey: String
    init(name: String, valueInDollar: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollar = valueInDollar
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        super.init()
    }
    
    convenience init(random: Bool = false){
        if random{
            let adjs = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            let randomadj = adjs[Int(arc4random_uniform(UInt32(adjs.count)))]
            let randomnoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            let randomName = "\(randomadj) \(randomnoun)"
            
            let randomValue = Int(arc4random_uniform(100))
            let randomSN = NSUUID().UUIDString
            
            self.init(name: randomName, valueInDollar: randomValue, serialNumber: randomSN)
        }
        else{
            self.init(name: "", valueInDollar: 100, serialNumber: nil)
        }
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(valueInDollar, forKey: "valueInDollar")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
    }
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        valueInDollar = aDecoder.decodeIntegerForKey("valueInDollar")
        serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String?
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        super.init()
    }
}
