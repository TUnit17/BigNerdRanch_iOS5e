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
    var sortedItem = [Item]()
    var groupedItem = [[Item]](count: 4, repeatedValue: [Item]())
    func createItem() -> Item{
        let newItem = Item(random: true)
        allItem.append(newItem)
        return newItem
    }
    init(){
        for _ in 1...20{
            createItem()
        }
        sortedItem = allItem.sort({$0.valueInDollar < $1.valueInDollar})
        var section = 0
        for item in sortedItem{
            while item.valueInDollar >= (section+1)*25{
                section += 1
            }
            groupedItem[section].append(item)
        }
    }
}
