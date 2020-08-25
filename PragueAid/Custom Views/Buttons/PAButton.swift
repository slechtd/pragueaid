//
//  PAButton.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 21/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit


enum PAButtonStyle {
    case navigate
    case call
    case favorite
}


class PAButton: UIButton {
    
    var style: PAButtonStyle?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(style: PAButtonStyle){
        self.init(frame: .zero)
        self.style = style
        generalConfig()
    }
    
    
    private func generalConfig(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        titleLabel?.font   = UIFont.preferredFont(forTextStyle: .headline)
        backgroundColor = .secondarySystemGroupedBackground
        tintColor = .systemRed
        
        switch style {
        case .navigate:
            configureNavigate()
        case .call:
            configureCall()
        case .favorite:
            configureFavorite()
        case .none:
            print("Error: No PAButtonStyle")
        }
    }
    
    
    private func configureNavigate(){
        self.setImage(UIImage(systemName: SFSymbol.nav.rawValue), for: .normal)
        
    }
    
    
    private func configureCall(){
        self.setImage(UIImage(systemName: SFSymbol.phone.rawValue), for: .normal)
    }
    
    
    private func configureFavorite(){
        self.setImage(UIImage(systemName: SFSymbol.star.rawValue), for: .normal)
    }
    
}
