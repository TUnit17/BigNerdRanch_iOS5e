//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Ivan Cai on 2/13/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController{
    var itemStore: ItemStore!
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        let item = itemStore.groupedItem[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$" + String(item.valueInDollar)
        return cell
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itemStore.groupedItem.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.groupedItem[section].count
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section*25)<=Value<=\((section+1)*25-1)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        let nomorecell = tableView.dequeueReusableCellWithIdentifier("NoMoreCell")
        nomorecell?.textLabel?.text = "No More Item"
        tableView.tableFooterView = nomorecell!
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
}
