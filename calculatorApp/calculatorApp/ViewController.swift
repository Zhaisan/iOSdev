//
//  ViewController.swift
//  calculatorApp
//
//  Created by Zhaisan on 31.01.2021.
//

import UIKit

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
    
    
    @IBOutlet weak var myDisplay: UILabel!
    
    var typing: Bool = false
    var checkDot: Bool = false
    
    @IBOutlet weak var AC_C_Button: UIButton!
    
    @IBAction func digitPressed(_ sender: UIButton) {
        AC_C_Button.setTitle("C", for: .normal)
        let current_digit = sender.currentTitle!
        if typing{
            let current_display = myDisplay.text!
            myDisplay.text = current_display + current_digit
            
        }
        else{
            myDisplay.text = current_digit
            typing = true
        }
        
    }
    var displayValue: Double{
        get{
            return Double(myDisplay.text!)!
        }
        set{
            myDisplay.text = String(newValue)
        }
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        if !checkDot{
            if(!typing){
                myDisplay.text! = "0."
            }
            else{
                myDisplay.text! += sender.currentTitle!
            }
            typing = true
            checkDot = true
        }
    }
    
    private var calculatorModel = CalculatorModel()
    @IBAction func operationPressed(_ sender: UIButton) {
        if calculatorModel.checkClear{
            AC_C_Button.setTitle("AC", for: .normal)
        }
        calculatorModel.setOperand(displayValue)
        calculatorModel.performOperation(sender.currentTitle!)
        displayValue = calculatorModel.result!
        
        typing = false
        checkDot = false
    }
    
} 

