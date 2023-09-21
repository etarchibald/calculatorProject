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
    
    @IBAction func numberButtons(_ sender: UIButton) {
        
        if areWeDoingSomething == true {
            mainLabel.text = ""
            mainLabel.text! += String(sender.tag-1)
            //Each number has a tag of one greater than the number it displays
            areWeDoingSomething = false
        } else {
            mainLabel.text! += String(sender.tag-1)
        }
        
//        clearButtonOutlet.setTitle("C", for: .normal)
        
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        mainLabel.text = ""
        firstNumber = 0
        secondNumber = 0
        areWeDoingSomething = false
        operation = 0
        isNumberNegative = false
        
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
            
            firstNumber = Double(mainLabel.text!)!
            
            if sender.tag == 12 { //Divide
                mainLabel.text?.append(" / ")
            }
            if sender.tag == 13 { //Multiply
                mainLabel.text?.append(" X ")
            }
            if sender.tag == 14 { //Subtract
                mainLabel.text?.append(" - ")
            }
            if sender.tag == 15 { //Add
                mainLabel.text?.append(" + ")
            }
            
            operation = sender.tag
            areWeDoingSomething = true
            
            if sender.tag == 17 { //PercentageButton
                mainLabel.text = String(firstNumber / 100)
                areWeDoingSomething = false
            }
        }
        
        if sender.tag == 16 { //Equals Button
            
            secondNumber = Double(mainLabel.text!)!
            
            if operation == 12 { //Divide Two Numbers
                mainLabel.text = String(firstNumber / secondNumber)
            }
            if operation == 13 { //Multiply Two Numbers
                mainLabel.text = String(firstNumber * secondNumber)
            }
            if operation == 14 { //Subtract Two Numbers
                mainLabel.text = String(firstNumber - secondNumber)
            }
            if operation == 15 { //Add Two Numbers
                mainLabel.text = String(firstNumber + secondNumber)
            }
//            if operation == 17 { //Find Percentage
//                mainLabel.text = String("\((firstNumber / secondNumber) * 100)")
//            }
        }
        
    }
    
}
