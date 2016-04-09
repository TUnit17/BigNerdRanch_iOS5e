//
//  ViewController.swift
//  Quiz
//
//  Created by Ivan Cai on 1/20/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentQuestion = 0;
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenter: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenter: NSLayoutConstraint!

    /*func animatedTransition() {
        view.layoutIfNeeded()
        self.nextQuestionLabelCenter.constant = 0
        self.currentQuestionLabelCenter.constant += view.frame.width
        UIView.animateWithDuration(1,
            delay: 0,
            options: [.CurveEaseOut],
            //options: [],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenter, &self.nextQuestionLabelCenter)
                self.nextQuestionLabelCenter.constant = -self.view.frame.width
            }
        )
        
    }*/
    
    func animatedTransition(){
        view.layoutIfNeeded()
        self.nextQuestionLabelCenter.constant = 0
        self.currentQuestionLabelCenter.constant += view.frame.width
        UIView.animateWithDuration(1,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 4,
            options: [],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
            
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenter, &self.nextQuestionLabelCenter)
                self.nextQuestionLabelCenter.constant = -self.view.frame.width
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text=getQuestion(currentQuestion)
        answerLabel.text = " "
        
        nextQuestionLabelCenter.constant = -view.frame.width
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
    }
    @IBAction func showNext(sender: UIButton){
        currentQuestion = currentQuestion+1
        nextQuestionLabel.text = getQuestion(currentQuestion)
        labelFadeout(answerLabel)
        animatedTransition()
    }
   /* @IBAction func showNext(sender: UIButton){
        labelFadeout(questionLabel)
        currentQuestion = currentQuestion+1
        questionLabel.text = getQuestion(currentQuestion)
        labelFadein(questionLabel)
        labelFadeout(answerLabel)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text=getQuestion(currentQuestion)
        answerLabel.text = " "
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }*/
    @IBAction func showAnswer(sender: UIButton){
        answerLabel.text = getAnswer(currentQuestion)
        labelFadein(answerLabel)
    }
    func labelFadein(label: UILabel) {
        UIView.animateWithDuration(0.5, animations: {label.alpha = 1.0})
    }
    func labelFadeout(label: UILabel) {
        UIView.animateWithDuration(0.5, animations: {label.alpha = 0})
    }
}

