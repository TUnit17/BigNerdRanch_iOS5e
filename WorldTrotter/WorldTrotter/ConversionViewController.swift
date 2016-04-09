//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Ivan Cai on 1/25/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var reallyLabel: UILabel!
    var backgound = false
    override func viewWillAppear(animated: Bool) {
        if (backgound){
            view.backgroundColor = UIColor.blackColor()
            reallyLabel.textColor = UIColor.whiteColor()
            backgound = false
        }
        else{
            view.backgroundColor = UIColor.init(red: 245/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1.0)
            reallyLabel.textColor = UIColor.blackColor()
            backgound = true
        }
    }
    let numberFormatter:NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    func updateCelsiusLabel(celsiusValue: Double?) {
        if let value = celsiusValue{
            celsiusLabel.text=numberFormatter.stringFromNumber(value)
        }
        else{
            celsiusLabel.text="???"
        }
    }
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField){
        if let text=textField.text, value = numberFormatter.numberFromString(text){
            //print(value.doubleValue)
            updateCelsiusLabel(value.doubleValue*5/9)
        }
        else{
            updateCelsiusLabel(nil)
        }
    }
    @IBAction func dismissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let decimalChars = NSMutableCharacterSet.decimalDigitCharacterSet()
        let decimalSeparator = NSLocale.currentLocale().objectForKey(NSLocaleDecimalSeparator) as! String
        decimalChars.addCharactersInString("-"+decimalSeparator)
        
        if (textField.text?.rangeOfString(decimalSeparator) != nil && string.rangeOfString(decimalSeparator) != nil) || (!string.isEmpty&&string.rangeOfCharacterFromSet(decimalChars) == nil) {
            return false
        }
        else{
            return true
        }
    }
}