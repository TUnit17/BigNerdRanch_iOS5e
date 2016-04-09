//
//  ItemStore.swift
//  Homepwner
//
//  Created by Ivan Cai on 2/13/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import Foundation
import UIKit

class ItemStore{
    var allItem = [Item]()
    let itemArchiveURL: NSURL = {
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        return documentsDirectory.URLByAppendingPathComponent("items.plist")
    }()
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as? [Item]{
            print("Loading items from: \(itemArchiveURL.path!)")
            allItem += archivedItems
        }
    }
    func createItem() -> Item{
        let newItem = Item(random: true)
        allItem.append(newItem)
        return newItem
    }
    func removeItem(item: Item){
        if let index = allItem.indexOf(item){
            allItem.removeAtIndex(index)
        }
    }
    func moveItemAtIndex(fromIndex: Int, toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let moveItem = allItem[fromIndex]
        allItem.removeAtIndex(fromIndex)
        allItem.insert(moveItem, atIndex: toIndex)
    }
    func saveChanges() ->Bool{
        print("Saving items to: \(itemArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allItem, toFile: itemArchiveURL.path!)
    }
}
