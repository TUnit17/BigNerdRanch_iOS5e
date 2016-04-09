//
//  Quizs.swift
//  Quiz
//
//  Created by Ivan Cai on 1/20/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import Foundation

private let questions: [String] = ["A first very long question","A second very long question","2+3"]
private let answers: [String] = ["2","3","5"]
func getQuestion(index: Int) ->String{
    /*if index >= questions.count{
        return "No more question"
    }
    else{
        return questions[index]
    }*/
    return questions[index % questions.count]
}
func getAnswer(index: Int) ->String{
    /*if index >= questions.count{
        return "No corresponding aswer"
    }
    else{
        return answers[index]
    }*/
    return answers[index % answers.count]
}
