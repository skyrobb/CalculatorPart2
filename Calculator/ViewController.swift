//
//  ViewController.swift
//  Calculator
//
//  Created by Skyler Robbins on 9/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var equals: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var decimal: UIButton!
    @IBOutlet weak var percent: UIButton!
    @IBOutlet weak var positiveOrNegative: UIButton!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet var numberButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var clearedText = "0"
    var canAddOperator = true
    enum operators {
        case plus
        case minus
        case multiply
        case divide
    }
    var calculation: [Any] = []
    
    func updateDisplay(with: String) {
        if display.text == "0" {
            if with != "." && with != "+" && with != "-" && with != "x" && with != "÷"{
                display.text = with
            } else {
                display.text! += with
            }
        } else {
            display.text! += with
        }
    }
    
    func clearDisplayText() {
        clearedText = display.text!
        display.text = "0"
        canAddOperator = true
        calculation = []
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        clearDisplayText()
    }
    
    @IBAction func positiveOrNegativePressed(_ sender: UIButton) {
        let currentText = display.text!
        if currentText.hasPrefix("-") {
            display.text = String(currentText.dropFirst())
        } else {
            display.text = "-\(currentText)"
        }
    }
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        let currentText = display.text!
        if currentText.contains(".") == false {
            updateDisplay(with: ".")
        }
        canAddOperator = false
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        updateDisplay(with: sender.configuration!.title!)
        calculation.append(sender.configuration!.title!)
        canAddOperator = true
    }
    
    
    @IBAction func plusPressed(_ sender: UIButton) {
        if canAddOperator {
            updateDisplay(with: "+")
            calculation.append(operators.plus)
            canAddOperator = false
        }
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        if canAddOperator {
            updateDisplay(with: "-")
            calculation.append(operators.minus)
            canAddOperator = false
        }
    }
    @IBAction func multiplyPressed(_ sender: UIButton) {
        if canAddOperator {
            updateDisplay(with: "x")
            calculation.append(operators.multiply)
            canAddOperator = false
        }
    }
    
    @IBAction func dividePressed(_ sender: UIButton) {
        if canAddOperator {
            updateDisplay(with: "÷")
            calculation.append(operators.divide)
            canAddOperator = false
        }
    }
    @IBAction func equalsPressed(_ sender: UIButton) {
        var numberAsString = ""
        var finalOutput = 0.0
        var number = 0.0
        for x in calculation {
            if x is String {
                numberAsString += x as! String
            } else if x is operators {
                number = Double(numberAsString)!
                switch x as! operators {
                case .plus:
                    finalOutput += number
                case .minus:
                    finalOutput -= number
                case .multiply:
                    finalOutput *= number
                case .divide:
                    finalOutput /= number
                }
                numberAsString = ""
            }
        }
        display.text = String(finalOutput)
        numberAsString = ""
        calculation = []
        calculation.append(String(finalOutput))
    }
}

