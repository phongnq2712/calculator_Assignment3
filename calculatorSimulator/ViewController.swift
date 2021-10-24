/**
 * Assignment 3
 * File Name:    ViewController.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        3.0
 * Date Created:   October 19th, 2021
 */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculationsLabel: UILabel!
    var calculationsText:String = ""
    var memoryAdd:Double = 0.0
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var btnRad: UIButton!
    @IBOutlet weak var btnCosh: UIButton!
    @IBOutlet weak var btnSinh: UIButton!
    @IBOutlet weak var btnTanh: UIButton!
    @IBOutlet weak var btnPi: UIButton!
    @IBOutlet weak var btnRand: UIButton!
    @IBOutlet weak var btnXFactorial: UIButton!
    @IBOutlet weak var btnSin: UIButton!
    @IBOutlet weak var btnCos: UIButton!
    @IBOutlet weak var btnTan: UIButton!
    @IBOutlet weak var btnE: UIButton!
    @IBOutlet weak var btnEe: UIButton!
    @IBOutlet weak var btn1divx: UIButton!
    @IBOutlet weak var btn2sqrtx: UIButton!
    @IBOutlet weak var btn3sqrtx: UIButton!
    @IBOutlet weak var btnLn: UIButton!
    @IBOutlet weak var btnySqrtx: UIButton!
    @IBOutlet weak var btnlog10: UIButton!
    @IBOutlet weak var btn2nd: UIButton!
    @IBOutlet weak var btnX2: UIButton!
    @IBOutlet weak var btnX3: UIButton!
    @IBOutlet weak var btnXy: UIButton!
    @IBOutlet weak var btnEx: UIButton!
    @IBOutlet weak var btn10x: UIButton!
    
    @IBOutlet weak var btnParenOpen: UIButton!
    @IBOutlet weak var btnParenClose: UIButton!
    @IBOutlet weak var btnMC: UIButton!
    @IBOutlet weak var btnMPlus: UIButton!
    @IBOutlet weak var btnMMinus: UIButton!
    @IBOutlet weak var btnMR: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyPortraitConstraint()
        // clear all labels
        clearAll()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

            let orient = UIApplication.shared.statusBarOrientation
                switch orient {
                case .portrait:
                    self.applyPortraitConstraint()
                    break
                default:
                    self.applyLandScapeConstraint()
                    break
                }
                }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in

            })
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    /**
     * Landscape mode
     */
    private func applyLandScapeConstraint()
    {
        self.btnMR.isHidden = false
        self.btnMC.isHidden = false
        self.btnMPlus.isHidden = false
        self.btnMMinus.isHidden = false
        self.btnParenOpen.isHidden = false
        self.btnParenClose.isHidden = false
        // 2nd row
        self.btn10x.isHidden = false
        self.btnEx.isHidden = false
        self.btnXy.isHidden = false
        self.btnX3.isHidden = false
        self.btnX2.isHidden = false
        self.btn2nd.isHidden = false
        // 3rd row
        self.btnlog10.isHidden = false
        self.btnLn.isHidden = false
        self.btnySqrtx.isHidden = false
        self.btn3sqrtx.isHidden = false
        self.btn2sqrtx.isHidden = false
        self.btn1divx.isHidden = false
        // 4th row
        self.btnEe.isHidden = false
        self.btnE.isHidden = false
        self.btnTan.isHidden = false
        self.btnCos.isHidden = false
        self.btnSin.isHidden = false
        self.btnXFactorial.isHidden = false
        // 5th row
        self.btnRad.isHidden = false
        self.btnSinh.isHidden = false
        self.btnCosh.isHidden = false
        self.btnTanh.isHidden = false
        self.btnPi.isHidden = false
        self.btnRand.isHidden = false
    }
    
    /*
     * Portrait mode
     */
    private func applyPortraitConstraint()
    {
        // 1st row
        self.btnMR.isHidden = true
        self.btnMC.isHidden = true
        self.btnMPlus.isHidden = true
        self.btnMMinus.isHidden = true
        self.btnParenOpen.isHidden = true
        self.btnParenClose.isHidden = true
        // 2nd row
        self.btn10x.isHidden = true
        self.btnEx.isHidden = true
        self.btnXy.isHidden = true
        self.btnX3.isHidden = true
        self.btnX2.isHidden = true
        self.btn2nd.isHidden = true
        // 3rd row
        self.btnlog10.isHidden = true
        self.btnLn.isHidden = true
        self.btnySqrtx.isHidden = true
        self.btn3sqrtx.isHidden = true
        self.btn2sqrtx.isHidden = true
        self.btn1divx.isHidden = true
        // 4th row
        self.btnEe.isHidden = true
        self.btnE.isHidden = true
        self.btnTan.isHidden = true
        self.btnCos.isHidden = true
        self.btnSin.isHidden = true
        self.btnXFactorial.isHidden = true
        // 5th row
        self.btnRad.isHidden = true
        self.btnSinh.isHidden = true
        self.btnCosh.isHidden = true
        self.btnTanh.isHidden = true
        self.btnPi.isHidden = true
        self.btnRand.isHidden = true
    }
    
        
    /**
     * Clear all text on two labels
     * Handling event for AC button
     */
    private func clearAll()
    {
        calculationsText = ""
        resultLabel.text = "0"
    }
    
    /**
     *  Handling event for  Backspace button
     */
    private func backSpace()
    {
        if(!calculationsText.isEmpty)
        {
            calculationsText.removeLast()
            resultLabel.text = calculationsText
        }
    }
    
    /**
     * Handling event for  percentage button
     */
    private func percentage()
    {
        if(!calculationsText.isEmpty && Double(calculationsText) != nil)
        {
            resultLabel.text = formatResult(result: Double(calculationsText)! / 100.0)
            calculationsText = resultLabel.text!
        }
    }
    
    /**
     * Handling event for Plus and Minus button
     */
    private func plusAndMinus()
    {
        // get all matches for complex calculation
        let allMatches = matchesRegex(for: "([-|+|x|/]?([0-9]+\\.?[0-9]*)+)", in: calculationsText)
        if(allMatches.count > 0)
        {
            //var lastElement = allMatches[allMatches.count - 1]
            var newCalculationText = ""
            for (index, element) in allMatches.enumerated() {
                if(index == allMatches.count - 1)
                {
                    var lastElememt = ""
                    if(element.prefix(1) == "+")
                    {
                        lastElememt.append("-" + element.dropFirst())
                    }
                    else if(element.prefix(1) == "-")
                    {
                        lastElememt.append("+" + element.dropFirst())
                    }
                    else
                    {
                        lastElememt.append("-" + element)
                    }
                    newCalculationText.append(lastElememt)
                } else {
                    newCalculationText.append(element)
                }
            }
            calculationsText = newCalculationText
            resultLabel.text = calculationsText
        }
    }

    /**
     * Handling event for special buttons
     */
    @IBAction func OnSpecialButon_Pressed(_ sender: UIButton) {
        let button_text = sender.titleLabel!.text!
        switch button_text
        {
        case "AC":
            clearAll()
            break
        case "<":
            backSpace()
            break
        case "%":
            percentage()
            break
        case "+/-":
            plusAndMinus()
            break
        default:
            calculationsText.append(button_text)
            break
        }
    }
    
    /**
     * Handling event for number buttons
     */
    @IBAction func OnNumerButton_Pressed(_ sender: UIButton) {
        let button_text = sender.titleLabel!.text!
        switch button_text
        {
        case ".":
            if(calculationsText.last != ".")
            {
                calculationsText.append(button_text)
            }
        case "0":
            if(calculationsText != "0")
            {
                calculationsText.append(button_text)
            }
        case "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if(calculationsText.prefix(1) == "0" && calculationsText.prefix(2) != "0.")
            {
                // remove "0" at first. Ex: "01" -> "1"
                calculationsText = ""
            }
            calculationsText.append(button_text)
        default:
            calculationsText.append(button_text)
                
        }
        resultLabel.text = calculationsText
    }
    
    /**
     * Get matching pattern regex for complex calculations
     */
    func matchesRegex(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex,options:.caseInsensitive)
            let results = regex.matches(in: text,
                                        range: NSRange(location: 0, length: text.count))
            let finalResult = results.map {
                (text as NSString).substring(with: $0.range)
            }
            
            return finalResult
        } catch let error {
            print("error regex: \(error.localizedDescription)")
            
            return []
        }
    }
    
    /**
     * Format for the result label
     * Floating point numbers should be accurate to at least 8 decimal places
     */
    private func formatResult(result: Double) -> String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return (String) (round(result * 100000000) / 100000000.0)
        }
    }
    
    fileprivate func multiplyCalculation(_ string: String) -> Double {
        // containing multiply (*)
        let splitStringMultiply = string.components(separatedBy: "x")
        var tempMultiplyResult = 1.0
        var dividedNumber = 1.0
        for element in splitStringMultiply
        {
            if(element.contains("/")) {
                let splitStringDivide = element.components(separatedBy: "/")
                for (index, divideElement) in splitStringDivide.enumerated()
                {
                    if(index == 0) {
                        tempMultiplyResult = tempMultiplyResult * Double(divideElement)!
                    } else {
                        dividedNumber = Double(divideElement)!
                    }
                }
                //tempMultiplyResult = tempMultiplyResult / Double(dividedNumber)!
                tempMultiplyResult = tempMultiplyResult / Double(dividedNumber)
            } else {
                tempMultiplyResult = tempMultiplyResult * Double(element)!
            }
        }
        
        return tempMultiplyResult
    }
    
    fileprivate func devideCalculation(_ element: String) -> Double {
        let splitStringDivide = element.components(separatedBy: "/")
        var tempDevideResult = 0.0
        
        for (i, e) in splitStringDivide.enumerated()
        {
            if(i == 0)
            {
                tempDevideResult += Double(e)!
            } else {
                tempDevideResult = tempDevideResult / Double(e)!
            }
        }
        
        return tempDevideResult
    }
    
    /**
     *   compound calculation in a series
     */
    private func calculate() -> Double
    {
        var total = 0.0
        let splitString = calculationsText.components(separatedBy: "+")
        if(!splitString.isEmpty)
        {
            for string in splitString
            {
                // containing minus (-)
                if(string.prefix(1) == "-")
                {
                    total += Double(string)!
                }
                else {
                    if(string.contains("-"))
                    {
                        let splitStringMinus = string.components(separatedBy: "-")
                        for (index, element) in splitStringMinus.enumerated()
                        {
                            if(index == 0) {
                                // multiply (*)
                                if(element.contains("x")) {
                                    let splitStringMultiply = element.components(separatedBy: "x")
                                    var tempMultiplyResult = 1.0
                                    for element1 in splitStringMultiply
                                    {
                                        tempMultiplyResult = tempMultiplyResult * Double(element1)!
                                    }
                                    total += tempMultiplyResult
                                }
                                // divide (/)
                                else if(element.contains("/")) {
                                    total += devideCalculation(element)
                                }
                                else
                                {
                                    // minus (-)
                                    total += Double(element)!
                                }
                            } else {
                                if(element.contains("x")) {
                                    total -= multiplyCalculation(element)
                                } else if(element.contains("/")) {
                                    total -= devideCalculation(element)
                                }
                                else {
                                    total -= Double(element)!
                                }
                            }
                        }
                    } else if(string.contains("x")) {
                        total += multiplyCalculation(string)
                    } else if(string.contains("/")) {
                        // containing divide (/)
                        total += devideCalculation(string)
                    } else {
                        total += Double(string)!
                    }
                }
            }
        }
        
        return total
    }
    
    /**
     * Handling event for operator buttons
     */
    @IBAction func OnOperatorButton_Pressed(_ sender: UIButton) {
        let button_text = sender.titleLabel!.text!
        switch button_text
        {
        case "mr":
            if(!calculationsText.contains(formatResult(result: memoryAdd))) {
                calculationsText.append(formatResult(result: memoryAdd))
                resultLabel.text = calculationsText
            }
        break
            
        case "m+":
            memoryAdd += Double(calculationsText)!
        break
            
        case "+":
            if(calculationsText.suffix(1) != "+")
            {
                calculationsText.append(button_text)
            }
            resultLabel.text = calculationsText
            break
        case "-":
            if(calculationsText.suffix(1) != "-")
            {
                calculationsText.append(button_text)
            }
            resultLabel.text = calculationsText
            break
        case "x":
            if(calculationsText.suffix(1) != "x")
            {
                calculationsText.append(button_text)
            }
            resultLabel.text = calculationsText
            break
        case "/":
            if(calculationsText.suffix(1) != "/")
            {
                calculationsText.append(button_text)
            }
            resultLabel.text = calculationsText
            break
        case "=":
            if(!calculationsText.isEmpty)
            {
                if(calculationsText.contains("^")) {
                    // caclculate x^y
                    let rsXBaseY = calculateXbaseY()
                    resultLabel.text = formatResult(result: rsXBaseY)
                    calculationsText = resultLabel.text!
                } else {
                    let result = calculate()
                    resultLabel.text = formatResult(result: result)
                    //resultLabel.text = "\(result)"
                    calculationsText = resultLabel.text!
                }
            }
            break
        default:
            break;
        }
    }
    
    /*
     * calculate x^y
     */
    private func calculateXbaseY() -> Double
    {
        var result = 1.0
        let splitString = calculationsText.components(separatedBy: "^")

        let y = Int(splitString[1])!
        for _ in 1...y
        {
            result *= Double(splitString[0])!
        }
        
        return result
    }
    
    @IBAction func onAdvancedButton_Pressed(_ sender: UIButton) {
        let button_text = sender.titleLabel!.text!
        switch button_text
        {
        case "x^2":
            resultLabel.text = formatResult(result: Double(calculationsText)! * Double(calculationsText)!)
            calculationsText = resultLabel.text!
        break
                
        case "x^3":
            resultLabel.text = formatResult(result: Double(calculationsText)! * Double(calculationsText)! * Double(calculationsText)!)
            calculationsText = resultLabel.text!
        break
        
        case "10^x":
            let base = Int(calculationsText)!
            var result = 1.0
            if(base > 0) {
                for _ in 1...base {
                    result = result * 10.0
                }
                resultLabel.text = formatResult(result: result)
                calculationsText = resultLabel.text!
            }
            
        break
            
        case "x^y":
            resultLabel.text?.append("^")// = formatResult(result: Double(calculationsText)! * Double(calculationsText)!)
            calculationsText = resultLabel.text!
        break
            
        case "x!":
            let number = Int(calculationsText)!
            var result = 1.0
            if(number == 0) {
                resultLabel.text = formatResult(result: result)
            } else {
                for n in 1...number {
                    result = result * Double(n)
                }
                resultLabel.text = formatResult(result: result)
            }
            calculationsText = resultLabel.text!
        break
        
        case "1/x":
            let dividedNumber = Double(calculationsText)!
            resultLabel.text = formatResult(result: 1/dividedNumber)
            calculationsText = resultLabel.text!
        break
            
        case "√x":
            let number = Double(calculationsText)!
            resultLabel.text = formatResult(result: sqrt(number))
            calculationsText = resultLabel.text!
        break
            
        case "log10":
            let number = Double(calculationsText)!
            resultLabel.text = formatResult(result: log10(number))
            calculationsText = resultLabel.text!
        break
        
        case "sin":
            let number = Double(calculationsText)!
            let sinus = sin(number * Double.pi / 180)
            resultLabel.text = formatResult(result: sinus)
            calculationsText = resultLabel.text!
        break
            
        case "sinh":
            let number = Double(calculationsText)!
            let sinhus = sinh(number)
            resultLabel.text = formatResult(result: sinhus)
            calculationsText = resultLabel.text!
        break
            
        case "cos":
            let number = Double(calculationsText)!
            let cosinus = cos(number * Double.pi / 180)
            resultLabel.text = formatResult(result: cosinus)
            calculationsText = resultLabel.text!
        break
            
        case "cosh":
            let number = Double(calculationsText)!
            let coshinus = cosh(number)
            resultLabel.text = formatResult(result: coshinus)
            calculationsText = resultLabel.text!
        break
            
        case "tan":
            let number = Double(calculationsText)!
            let tangent = tan(number * Double.pi / 180)
            resultLabel.text = formatResult(result: tangent)
            calculationsText = resultLabel.text!
        break
            
        case "tanh":
            let number = Double(calculationsText)!
            let tanhgent = tanh(number)
            resultLabel.text = formatResult(result: tanhgent)
            calculationsText = resultLabel.text!
        break
            
        case "Rand":
            let randomDouble = Double.random(in: 0...1)
            resultLabel.text = formatResult(result: randomDouble)
            calculationsText = resultLabel.text!
        break
            
        case "π":
            resultLabel.text = formatResult(result: Double.pi)
            calculationsText = resultLabel.text!
        break
            
        default:
        break
        }
    }
}

