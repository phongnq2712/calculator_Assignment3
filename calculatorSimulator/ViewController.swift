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
    @IBOutlet weak var resultLabel: UILabel!
    var calculationsText:String = ""
    
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
        // clear all labels
        clearAll()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

            let orient = UIApplication.shared.statusBarOrientation
                switch orient {
                case .portrait:
                    print("Portrait")
                    self.applyPortraitConstraint()
                    break
                    // Do something
                default:
                    print("LandScape")
                    // Do something else
//                    self.applyLandScapeConstraint()
                    break
                }
                }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in

            })
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    private func applyPortraitConstraint()
    {
        // 1st row
        self.btnMR.removeFromSuperview()
        self.btnMC.removeFromSuperview()
        self.btnMPlus.removeFromSuperview()
        self.btnMMinus.removeFromSuperview()
        self.btnParenOpen.removeFromSuperview()
        self.btnParenClose.removeFromSuperview()
        // 2nd row
        self.btn10x.removeFromSuperview()
        self.btnEx.removeFromSuperview()
        self.btnXy.removeFromSuperview()
        self.btnX3.removeFromSuperview()
        self.btnX2.removeFromSuperview()
        self.btn2nd.removeFromSuperview()
        // 3rd row
        self.btnlog10.removeFromSuperview()
        self.btnLn.removeFromSuperview()
        self.btnySqrtx.removeFromSuperview()
        self.btn3sqrtx.removeFromSuperview()
        self.btn2sqrtx.removeFromSuperview()
        self.btn1divx.removeFromSuperview()
        // 4th row
        self.btnEe.removeFromSuperview()
        self.btnE.removeFromSuperview()
        self.btnTan.removeFromSuperview()
        self.btnCos.removeFromSuperview()
        self.btnSin.removeFromSuperview()
        self.btnXFactorial.removeFromSuperview()
        // 5th row
        self.btnRad.removeFromSuperview()
        self.btnSinh.removeFromSuperview()
        self.btnCosh.removeFromSuperview()
        self.btnTanh.removeFromSuperview()
        self.btnPi.removeFromSuperview()
        self.btnRand.removeFromSuperview()
    }
    
        
    /**
     * Clear all text on two labels
     * Handling event for AC button
     */
    private func clearAll()
    {
//        calculationsText = ""
//        calculationsLabel.text = ""
//        resultLabel.text = "0"
    }
    
    /**
     *  Handling event for  Backspace button
     */
    private func backSpace()
    {
        if(!calculationsText.isEmpty)
        {
            calculationsText.removeLast()
            calculationsLabel.text = calculationsText
        }
    }
    
    /**
     * Handling event for  percentage button
     */
    private func percentage()
    {
        if(!calculationsText.isEmpty && Double(calculationsText) != nil)
        {
            calculationsLabel.text = formatResult(result: Double(calculationsText)! / 100.0)
            calculationsText = calculationsLabel.text!
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
            calculationsLabel.text = calculationsText
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
        calculationsLabel.text = calculationsText
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
    
    /**
     *   compound calculation in a series
     */
    private func calculate() -> Double
    {
        // get all matches for complex calculation
        let allMatches = matchesRegex(for: "([-|+|x|/]?([0-9]+\\.?[0-9]*)+)", in: calculationsText)
        // loop array of match
        // Example: 1+3-2 -> ["1","+3","-2"]
        var total = 0.0
        for match in allMatches
        {
            switch match.prefix(1) {
            case "+":
                total += Double(String(match.dropFirst()))!
                break
            case "-":
                total += Double(String(match))!
                break
            case "x":
                total *= Double(String(match.dropFirst()))!
                break
            case "/":
                total /= Double(String(match.dropFirst()))!
                break
            default:
                total += Double(match)!
                break
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
        case "+":
            if(calculationsText.suffix(1) != "+")
            {
                calculationsText.append(button_text)
            }
            calculationsLabel.text = calculationsText
            break
        case "-":
            if(calculationsText.suffix(1) != "-")
            {
                calculationsText.append(button_text)
            }
            calculationsLabel.text = calculationsText
            break
        case "x":
            if(calculationsText.suffix(1) != "x")
            {
                calculationsText.append(button_text)
            }
            calculationsLabel.text = calculationsText
            break
        case "/":
            if(calculationsText.suffix(1) != "/")
            {
                calculationsText.append(button_text)
            }
            calculationsLabel.text = calculationsText
            break
        case "=":
            if(!calculationsText.isEmpty)
            {
                let result = calculate()
                resultLabel.text = formatResult(result: result)
                //resultLabel.text = "\(result)"
                calculationsText = ""
            }
            break
        default:
            break;
        }
    }
}

