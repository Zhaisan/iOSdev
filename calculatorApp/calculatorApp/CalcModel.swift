 //
//  CalcModel.swift
//  calculatorApp
//
//  Created by Zhaisan on 04.02.2021.
//

import Foundation
 
enum Operation{
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double, Double)->Double)
    case equals
    case clear
}

 func addition(op1: Double, op2: Double)-> Double{
    return op1 + op2
 }
 
 func subtraction(op1: Double, op2: Double)-> Double{
    return op1 - op2
 }
 
 func multiplying(op1: Double, op2: Double)-> Double{
    return op1 * op2
 }
 
 func division(op1: Double, op2: Double)-> Double{
    return op1 / op2
 }
 
 func percentage(op1: Double, op2: Double)-> Double{
    return op1 * op2 / 100
 }
 
 func makenegative(op1: Double) -> Double{
    return op1 * (-1)
 }
 


struct CalculatorModel{
    var my_operation: Dictionary<String, Operation> =
    [
        "+": Operation.binaryOperation(addition),
        "-": Operation.binaryOperation(subtraction),
        "×": Operation.binaryOperation(multiplying),
        "÷": Operation.binaryOperation(division),
        "%": Operation.binaryOperation(percentage),
        "AC": Operation.constant(0),
        "C": Operation.clear,
        "±": Operation.unaryOperation(makenegative),
        "=": Operation.equals
    ]
    
    private var global_value: Double?
    var checkClear: Bool = false
    var checkEquals: Bool = false
    
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    
    mutating func performOperation(_ operation: String){
        let symbol = my_operation[operation]!
        
        switch symbol {
        
        case .constant(let value):
            global_value = value
            
            
            
        case .unaryOperation(let function):
            checkClear = false
            global_value = function(global_value!)
            
        case .binaryOperation(let function):
            checkClear = false
            if(!checkEquals){
                checkEquals = true
            }
            else{
                global_value = saving?.performOperationWith(secondOperand: global_value!)
            }
            saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
            
        case .equals:
            checkClear = false
            if global_value != nil{
                global_value = saving?.performOperationWith(secondOperand: global_value!)
                checkEquals = false
            }
        case .clear:
            checkClear = true
            global_value = 0
        
        default:
            break
        }
    }
    
    var result: Double?{
        get{
            return global_value
        }
    }
    
    private var saving: SaveFirstOperandAndOperation?
    struct SaveFirstOperandAndOperation {
        let firstOperand: Double
        let operation: (Double, Double)-> Double
        
        func performOperationWith(secondOperand op2: Double)-> Double{
            return operation(firstOperand, op2)
        }
    }
}

