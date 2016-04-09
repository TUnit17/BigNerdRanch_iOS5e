//
//  Item.swift
//  Homepwner
//
//  Created by Ivan Cai on 2/13/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject{
    var name: String
    var valueInDollar: Int
    var serialNumber: String?
    let dateCreated: NSDate
    
    init(name: String, valueInDollar: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollar = valueInDollar
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        
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
}
