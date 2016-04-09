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
}
