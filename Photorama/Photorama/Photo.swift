//
//  Photo.swift
//  Photorama
//
//  Created by Ivan Cai on 4/1/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Photo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    var image: UIImage?
    
    override func awakeFromInsert() {
        title = ""
        photoID = ""
        remoteURL = NSURL()
        photoKey = NSUUID().UUIDString
        dateTaken = NSDate()
    }
    
    func addTagObject(tag: NSManagedObject){
        let currentTags = mutableSetValueForKey("tags")
        currentTags.addObject(tag)
    }
    
    func removeTagObject(tag: NSManagedObject){
        let currentTags = mutableSetValueForKey("tags")
        currentTags.removeObject(tag)
    }
}
