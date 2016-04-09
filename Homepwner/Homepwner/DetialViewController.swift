//
//  DetialViewController.swift
//  Homepwner
//
//  Created by Ivan Cai on 3/5/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit
class MyTextField: UITextField{
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        self.borderStyle = .Bezel
        return true
    }
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        self.borderStyle = .RoundedRect
        return true
    }
}

class DetialViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var valueField: MyTextField!
    @IBOutlet var nameField: MyTextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var serialNumberField: MyTextField!
    
    @IBOutlet var imageView: UIImageView!
    
    var item: Item!{
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    let dateFormatter: NSDateFormatter = {
       let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollar)
        dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        
        let imageToDisplay = imageStore.imageForKey(item.itemKey)
        imageView.image = imageToDisplay
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, value = numberFormatter.numberFromString(valueText){
            item.valueInDollar = value.integerValue
        }
        else{
            item.valueInDollar = 0
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func takePicture(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        }
        else{
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image, forKey:item.itemKey)
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func removeImage(sender: AnyObject) {
        imageView.image = nil
        imageStore.deleteImageForKey(item.itemKey)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTime"{
            let timeViewController = segue.destinationViewController as! TimeViewController
            timeViewController.item = self.item
        }
    }
}
