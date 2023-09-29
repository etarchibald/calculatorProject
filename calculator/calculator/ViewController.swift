//
//  ViewController.swift
//  calculator
//
//  Created by Ethan Archibald on 9/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var clearButtonOutlet: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    
    @IBOutlet var arrayOfButtonOperators: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button0.layer.cornerRadius = 50
        button0.layer.masksToBounds = true
    }
    
    
    var firstNumber: Double = 0;
    var secondNumber: Double = 0;
    var areWeDoingSomething = false;
    var operation = 0;
    var isNumberNegative = false
    var AreWeClearingEverything = true
    var areWeCompounding = false
    
    func originalColorsOfOperators(button: UIButton) {
        button.backgroundColor = UIColor.systemOrange
        button.tintColor = UIColor.white
    }
    
    func OffColorsOfOperators(button: UIButton) {
        button.backgroundColor = UIColor.white
        button.tintColor = UIColor.systemOrange
    }
    
    func setAsclearButton(button: UIButton) {
        button.setTitle("C", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40)
        AreWeClearingEverything = false
    }
    
    func setAsAllClearButton(button: UIButton) {
        button.setTitle("AC", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40)
        AreWeClearingEverything = true
    }
    
    func clearEveryThing() {
        mainLabel.text = ""
        firstNumber = 0
        secondNumber = 0
        areWeDoingSomething = false
        operation = 0
        isNumberNegative = false
        areWeCompounding = false
    }
    
    func setOperatorsToOriginalColors(button: [UIButton]) {
        for each in button {
            originalColorsOfOperators(button: each)
        }
    }
    
    func performCalculation(first: Double, second: Double) {
        if operation == 12 { //Divide Two Numbers
            mainLabel.text = String(first / second)
            originalColorsOfOperators(button: divideButton)
        }
        if operation == 13 { //Multiply Two Numbers
            mainLabel.text = String(first * second)
            originalColorsOfOperators(button: multiplyButton)
        }
        if operation == 14 { //Subtract Two Numbers
            mainLabel.text = String(first - second)
            originalColorsOfOperators(button: subtractButton)
        }
        if operation == 15 { //Add Two Numbers
            mainLabel.text = String(first + second)
            originalColorsOfOperators(button: addButton)
        }
//        areWeDoingSomething = false
    }
    
    
    @IBAction func numberButtons(_ sender: UIButton) {
        
        if areWeDoingSomething == true {
            mainLabel.text = ""
            mainLabel.text! += String(sender.tag-1)
            //Each number has a tag of one greater than the number it displays
            areWeDoingSomething = false
            setAsclearButton(button: clearButtonOutlet)
            areWeCompounding = true
        } else {
            mainLabel.text! += String(sender.tag-1)
        }
        
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        if AreWeClearingEverything == true {
            clearEveryThing()
            setOperatorsToOriginalColors(button: arrayOfButtonOperators)
        } else if AreWeClearingEverything == false && mainLabel.text != "" {
            mainLabel.text = ""
            setAsAllClearButton(button: clearButtonOutlet)
        }
        
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        
        if mainLabel.text == "" || areWeDoingSomething == true {
            mainLabel.text = ""
            mainLabel.text! = "0."
            areWeDoingSomething = false
        } else {
            mainLabel.text! += "."
        }
    }
    
    @IBAction func posNegButton(_ sender: Any) {
        
        if isNumberNegative == false {
            mainLabel.text?.insert("-", at: mainLabel.text!.startIndex)
            isNumberNegative = true
        } else if isNumberNegative == true {
            let removeNeg: Set<Character> = ["-"]
            mainLabel.text?.removeAll(where: { removeNeg.contains($0)})
            isNumberNegative = false
        }
        
    }
    
    @IBAction func operators(_ sender: UIButton) {
        
        if mainLabel.text != "" && sender.tag != 16 {
            
            if areWeCompounding == false {
                firstNumber = Double(mainLabel.text!)!
            }
            
            func FindingOutifWeAreDoingSomething(button: UIButton) {
                if areWeDoingSomething == true {
                    originalColorsOfOperators(button: sender)
                    operation = 0
                    areWeDoingSomething = false
                } else {
                    OffColorsOfOperators(button: sender)
                    areWeDoingSomething = true
                }
            }
            
            if areWeCompounding == true {
                areWeCompounding = false
                secondNumber = Double(mainLabel.text!)!
                performCalculation(first: firstNumber, second: secondNumber)
                firstNumber = Double(mainLabel.text!)!
            }
            
            
            if sender.tag == 12 { //Divide
                FindingOutifWeAreDoingSomething(button: sender)
            }
            if sender.tag == 13 { //Multiply
                FindingOutifWeAreDoingSomething(button: sender)
            }
            if sender.tag == 14 { //Subtract
                FindingOutifWeAreDoingSomething(button: sender)
            }
            if sender.tag == 15 { //Add
                FindingOutifWeAreDoingSomething(button: sender)
            }
            if sender.tag == 17 { //PercentageButton
                mainLabel.text = String(firstNumber / 100)
                areWeDoingSomething = false
            }
            
            operation = sender.tag
            
        }
        
        if sender.tag == 16 { //Equals Button
            secondNumber = Double(mainLabel.text!)!
            performCalculation(first: firstNumber, second: secondNumber)
            setAsAllClearButton(button: clearButtonOutlet)
            areWeCompounding = false
            areWeDoingSomething = false
            setOperatorsToOriginalColors(button: arrayOfButtonOperators)
        }
        
    }
    
}
