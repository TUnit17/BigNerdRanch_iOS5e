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
    @IBAction func addNewItem(sender: UIButton){
        let newItem = itemStore.createItem()
        if let index = itemStore.allItem.indexOf(newItem){
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
    }
    @IBAction func toggleEditingMode(sender: UIButton){
        if editing{
            sender.setTitle("Edit", forState: .Normal)
            setEditing(false, animated: true)
        }
        else{
            sender.setTitle("Done", forState: .Normal)
            setEditing(true, animated: true)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItem.count + 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        if indexPath.row == itemStore.allItem.count{
            let cell = tableView.dequeueReusableCellWithIdentifier("NoMoreItem", forIndexPath: indexPath)
            cell.textLabel?.text = "No more item!"
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        let item = itemStore.allItem[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$" + String(item.valueInDollar)
        
        return cell
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let item = itemStore.allItem[indexPath.row]
            if item.valueInDollar <= 50{
                self.itemStore.removeItem(item)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            else{
                let title = "Delete \(item.name)"
                let message = "Are you sure you want to delete this EXPENSIVE item?"
                let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
                let cancelaction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                let deleteaction = UIAlertAction(title: "Remove", style: .Destructive,
                    handler: { (action)-> Void in
                        self.itemStore.removeItem(item)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    })
                
                ac.addAction(deleteaction)
                ac.addAction(cancelaction)
                presentViewController(ac, animated: true, completion: nil)
            }
        }
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        if sourceIndexPath.row < itemStore.allItem.count && proposedDestinationIndexPath.row < itemStore.allItem.count{
            return proposedDestinationIndexPath
        }
        else{
            return sourceIndexPath
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = 65
    }
}
