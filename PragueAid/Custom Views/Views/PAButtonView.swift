//
//  PATargetHeaderView.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit


enum PAButtonViewStyle {
    case target
    case about
}


class PAButtonView: UIView {
    
    let stackView = UIStackView()
    
    var leftButton: PAButton?
    var rightButton: PAButton?
    var style: PAButtonViewStyle?
    
    
    init(frame: CGRect, style: PAButtonViewStyle) {
        super.init(frame: frame)
        self.style = style
        configureStackView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureStackView(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        self.addSubview(stackView)
        
        switch style {
        case .target:
            leftButton = PAButton(style: .navigate)
            rightButton = PAButton(style: .call)
            stackView.addArrangedSubview(leftButton!)
            if UIDevice.current.userInterfaceIdiom == .phone {stackView.addArrangedSubview(rightButton!)}
        case .about:
            leftButton = PAButton(style: .github)
            rightButton = PAButton(style: .linkedIn)
            stackView.addArrangedSubview(leftButton!)
            stackView.addArrangedSubview(rightButton!)
        case .none:
            print("Error: No PAButtonViewStyle")
        }

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
        if UIDevice.current.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([stackView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.30)])
        } else {
            NSLayoutConstraint.activate([stackView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.90)])
        }
    }
}
