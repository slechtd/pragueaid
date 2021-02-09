//
//  PATargetHeaderView.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit

class PATargetHeaderView: UIView {
    
    let stackView = UIStackView()
    let navButton = PAButton(style: .navigate)
    let callButton = PAButton(style: .call)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        stackView.addArrangedSubview(navButton)
        stackView.addArrangedSubview(callButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: self.frame.height),
            stackView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.95)
        ])
    }
    
}
