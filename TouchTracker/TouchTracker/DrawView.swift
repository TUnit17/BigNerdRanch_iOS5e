//
//  DrawView.swift
//  TouchTracker
//
//  Created by Ivan Cai on 3/17/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import Foundation
import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate {
    //MARK: Lines in the view
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    var selectedLineIndex: Int?{
        didSet{
            if selectedLineIndex == nil{
                let menu = UIMenuController.sharedMenuController()
                menu.setMenuVisible(false, animated: true)
            }
        }
    }
    var moveRecognizer: UIPanGestureRecognizer!
    // MARK: Values to be modified in Interface Builder
    @IBInspectable var finishedLineColor: UIColor = UIColor.blackColor(){
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.redColor(){
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10{
        didSet{
            setNeedsDisplay()
        }
    }
    
    // MARK: Draw Lines
    func strokeLine(line: Line){
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.Round
        
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    func strokeOval(line: Line){
        let path = UIBezierPath(ovalInRect: linetoRect(line))
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.Round
        path.stroke()
    }
    override func drawRect(rect: CGRect) {
        finishedLineColor.setStroke()
        for line in finishedLines {
            strokeLine(line)
        }
        //currentLineColor.setStroke()
        for (_,line) in currentLines{
            var angle: CGFloat
            
            let deltaX = line.end.x - line.begin.x
            let deltaY = line.end.y - line.begin.y
            angle = abs((atan(deltaY/deltaX)))
            let colorWithAlpha = UIColor.blueColor().colorWithAlphaComponent((angle / (CGFloat(M_PI)/2))/2+0.5)
            colorWithAlpha.setStroke()
            strokeLine(line)
        }
        
        if let index = selectedLineIndex{
            UIColor.greenColor().setStroke()
            let selectedLine = finishedLines[index]
            strokeLine(selectedLine)
        }
    }
    
    // MARK: Handling touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Fixed Silver Challenge
        if let _ = selectedLineIndex{
            selectedLineIndex = nil
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        for touch in touches{
            let location = touch.locationInView(self)
            let newline = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newline
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.locationInView(self)
        }
        setNeedsDisplay()
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key]{
                line.end = touch.locationInView(self)
                finishedLines.append(line)
                currentLines.removeValueForKey(key)
            }
        }
        setNeedsDisplay()
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        currentLines.removeAll()
        setNeedsDisplay()
    }
    func linetoRect(line: Line)->CGRect{
        let xMin = min(line.begin.x, line.end.x)
        let xMax = max(line.begin.x, line.end.x)
        let yMin = min(line.begin.y, line.end.y)
        let yMax = max(line.begin.y, line.end.y)
        let width = xMax - xMin
        let height = yMax - yMin
        
        return CGRect(x: xMin, y: yMin, width: width, height: height)
    }
    
    // MARK: Custom view class
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // MARK: Gesture Recognizers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: "moveLine:")
        moveRecognizer.cancelsTouchesInView = false
        
        moveRecognizer.requireGestureRecognizerToFail(tapRecognizer)
        moveRecognizer.delegate = self
        addGestureRecognizer(moveRecognizer)
    }
    func doubleTap(gestureRecognizer: UIGestureRecognizer){
        selectedLineIndex = nil
        currentLines.removeAll(keepCapacity: false)
        finishedLines.removeAll(keepCapacity: false)
        setNeedsDisplay()
    }
    func indexOFLineAtPoint(point: CGPoint) -> Int?{
        for (index,line) in finishedLines.enumerate(){
            let begin = line.begin
            let end = line.end
            
            for t in CGFloat(0).stride(to: 1.0, by: 0.05){
                let x = begin.x+((end.x-begin.x)*t)
                let y = begin.y+((end.y-begin.y)*t)
                if hypot(x-point.x, y-point.y)<5.0 {
                    return index
                }
            }
        }
        return nil
    }
    func tap(gestureRecognizer: UIGestureRecognizer){
        let point = gestureRecognizer.locationInView(self)
        selectedLineIndex = indexOFLineAtPoint(point)
        let menu = UIMenuController.sharedMenuController()
        if selectedLineIndex != nil{
            becomeFirstResponder()
            let deleteItem = UIMenuItem(title: "Delete", action: "deleteLine:")
            menu.menuItems = [deleteItem]
            menu.setTargetRect(CGRect(x: point.x,y: point.y,width: 2,height:2), inView: self)
            menu.setMenuVisible(true, animated: true)
        }
        else{
            menu.setMenuVisible(false, animated: true)
        }
        setNeedsDisplay()
    }
    func deleteLine(sender: AnyObject) {
        if let index = selectedLineIndex{
            finishedLines.removeAtIndex(index)
            selectedLineIndex = nil
            setNeedsDisplay()
        }
    }
    func longPress(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == .Began{
            let point = gestureRecognizer.locationInView(self)
            selectedLineIndex = indexOFLineAtPoint(point)
            
            if selectedLineIndex != nil{
                currentLines.removeAll(keepCapacity: false)
            }
        }
        else if gestureRecognizer.state == .Ended{
            selectedLineIndex = nil
        }
        setNeedsDisplay()
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func moveLine(gestureRecognizer: UIPanGestureRecognizer){
        if let index = selectedLineIndex{
            if gestureRecognizer.state == .Changed{
                let translation = gestureRecognizer.translationInView(self)
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                gestureRecognizer.setTranslation(CGPoint.zero, inView: self)
                setNeedsDisplay()
            }
        }
        else{
            return
        }
    }
}
