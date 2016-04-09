//
//  TagDataSource.swift
//  Photorama
//
//  Created by Ivan Cai on 4/8/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TagDataSource: NSObject, UITableViewDataSource{
    var tags: [NSManagedObject] = []
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        let tag = tags[indexPath.row]
        let name = tag.valueForKey("name") as! String
        cell.textLabel?.text = name
        //print("Try to display")
        return cell
    }
}