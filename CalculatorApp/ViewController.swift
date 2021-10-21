//
//  ViewController.swift
//  CalculatorApp
//
//  Created by SGMobile on 17/09/21.
//  Copyright © 2021 Scientific Games. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstNumber = 0
    var secondNumber = 0
    var currentOperations: Operation?
    
    enum Operation {
        case add,sub,mul,divide,clear,neg,rem
    }
    
//    enum Operation1 {
//        case clear,neg,rem
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(holder)
        holder.addSubview(resultLabel)
        SetUpAutoLayout()
        setUpNumberPad()
    }
    
    //view to hold all the buttons and result label
    private var holder:UIView = {
      let view = UIView()
      view.backgroundColor = .black
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    //Label to display result
    private let resultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Arial", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //creating auto layout constraints        .
    func SetUpAutoLayout() {
        holder.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        holder.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        holder.heightAnchor.constraint(equalToConstant: view.frame.height/1.1).isActive = true
        holder.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        resultLabel.topAnchor.constraint(equalTo: holder.topAnchor, constant:280).isActive = true
        resultLabel.leftAnchor.constraint(equalTo: holder.leftAnchor, constant:40).isActive = true
        resultLabel.rightAnchor.constraint(equalTo: holder.rightAnchor, constant:-10).isActive = true
        resultLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    //structuring buttons in the same mannner as in calculator app
    private func setUpNumberPad(){
        let buttonSize : CGFloat = view.frame.size.width / 4

        let zeroBtn = CustomButton(frame: CGRect(x: 0, y: view.frame.size.height-buttonSize, width: buttonSize*2, height: buttonSize))
        zeroBtn.configure(with: CustomButtonViewModel(btnText: "0", btnColor: .gray))
        view.addSubview(zeroBtn)
        zeroBtn.tag = 1
        zeroBtn.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        let dotBtn = CustomButton(frame: CGRect(x: zeroBtn.frame.size.width, y: view.frame.size.height-buttonSize, width: buttonSize, height: buttonSize))
        dotBtn.configure(with: CustomButtonViewModel(btnText: ".", btnColor: .gray))
        view.addSubview(dotBtn)
        dotBtn.tag = 2
        //zeroBtn.addTarget(self, action: #selector(dotTapped), for: .touchUpInside)

        for x in 0..<3 {
            let button1 = CustomButton(frame: CGRect(x: buttonSize * CGFloat(x), y: view.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.configure(with: CustomButtonViewModel(btnText: "\(x+1)", btnColor: .gray))
            view.addSubview(button1)
            button1.tag = x+2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }

        for x in 0..<3 {
            let button2 = CustomButton(frame: CGRect(x: buttonSize * CGFloat(x), y: view.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.configure(with: CustomButtonViewModel(btnText: "\(x+4)", btnColor: .gray))
            view.addSubview(button2)
            button2.tag = x+5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }

        for x in 0..<3 {
            let button3 = CustomButton(frame: CGRect(x: buttonSize * CGFloat(x), y: view.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.configure(with: CustomButtonViewModel(btnText: "\(x+7)", btnColor: .gray))
            view.addSubview(button3)
            button3.tag = x+8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        let operations1 = ["AC", "+/-", "%"]
        for x in 0..<3{
            let button4 = CustomButton(frame: CGRect(x: buttonSize * CGFloat(x), y: view.frame.size.height-(buttonSize*5), width: buttonSize, height: buttonSize))
            button4.configure(with: CustomButtonViewModel(btnText: operations1[x], btnColor: .gray))
            view.addSubview(button4)
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        let operations2 = ["=", "+", "-", "X", "/"]
        for x in 0..<5{
            let button5 = CustomButton(frame: CGRect(x: buttonSize * 3, y: view.frame.size.height-(buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
            button5.configure(with: CustomButtonViewModel(btnText: operations2[x], btnColor: .orange))
            view.addSubview(button5)
            button5.tag = x+1
            button5.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        
    }
    
    //on click of AC button
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
    }
    
    //on click of 0 button
    @objc func zeroTapped(_ sender: UIButton) {
        
        if(resultLabel.text == "0"){
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
//    @objc func dotTapped(_ sender: UIButton) {
//
//        if(resultLabel.text == "0"){
//            if let text = resultLabel.text {
//                resultLabel.text = "\(text)\(.)"
//            }
//        }
//    }
    
    
    ////on click of number button
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if(resultLabel.text == "0"){
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    //on click of operation button
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0{
            firstNumber = value
            resultLabel.text = "0"
        }
        
        
        if tag == 1{
            if let operation = currentOperations{
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text){
                    secondNumber = value
                }
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .sub:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .mul:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .clear:
                    resultLabel.text = "0"
                    currentOperations = nil
                    firstNumber = 0
                    break
                case .neg:
                    resultLabel.text = "\(-firstNumber))"
                    break
                case .rem:
                    let result = firstNumber/100
                    resultLabel.text = "\(result)"
                    break
                }
            }
        }
        else if tag == 2 {
            currentOperations = .add
        }
        else if tag == 3 {
            currentOperations = .sub
        }
        else if tag == 4 {
            currentOperations = .mul
        }
        else if tag == 5 {
            currentOperations = .divide
        }
        
    }
    
    
}

