//
//  CustomButton.swift
//  CalculatorApp
//
//  Created by SGMobile on 17/09/21.
//  Copyright © 2021 Scientific Games. All rights reserved.
//

import UIKit

//Model class
struct CustomButtonViewModel {
    let btnText: String
    let btnColor: UIColor?
}

//Creating custom UIButton
class CustomButton: UIButton {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        clipsToBounds = true
        layer.cornerRadius = 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    func configure(with viewModel: CustomButtonViewModel){
        textLabel.text = viewModel.btnText
        textLabel.backgroundColor = viewModel.btnColor
    }
}
