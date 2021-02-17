//
//  PASecondaryLabel.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 21/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit

class PASecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.textColor = .secondaryLabel
        self.textAlignment = .center
    }
}

