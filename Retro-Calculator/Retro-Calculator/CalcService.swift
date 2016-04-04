//
//  CalcService.swift
//  Retro-Calculator
//
//  Created by Ralph Cachero on 4/1/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import Foundation

class CalcService {
    static let instance = CalcService()
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    func multiply(numStrA: String, numStrB: String) -> String? {
        if let numA = Double(numStrA), let numB = Double(numStrB) {
            return "\(numA * numB)"
        } else {
            return nil
        }
    }
    
    func divide(numStrA: String, numStrB: String) -> String? {
        if let numA = Double(numStrA), let numB = Double(numStrB) {
            return "\(numA / numB)"
        } else {
            return nil
        }
    }
    
    func subtract(numStrA: String, numStrB: String) -> String? {
        if let numA = Double(numStrA), let numB = Double(numStrB) {
            return "\(numA - numB)"
        } else {
            return nil
        }
    }
    
    func add(numStrA: String, numStrB: String) -> String? {
        if let numA = Double(numStrA), let numB = Double(numStrB) {
            return "\(numA + numB)"
        } else {
            return nil
        }
    }
    
//    if currentOperation == CalcService.Operation.Multiply {
//    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
//    } else if currentOperation == CalcService.Operation.Divide {
//    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
//    } else if currentOperation == CalcService.Operation.Subtract {
//    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
//    } else if currentOperation == CalcService.Operation.Add {
//    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
//    }

}
