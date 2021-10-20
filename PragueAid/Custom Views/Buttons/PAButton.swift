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
    case github
    case linkedIn
}


class PAButton: UIButton {
    
    let padding: CGFloat = 13
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
        layer.cornerRadius = 10
        titleLabel?.font   = UIFont.preferredFont(forTextStyle: .headline)
        backgroundColor = .secondarySystemGroupedBackground
        tintColor = .systemRed
        
        
        switch style {
        case .navigate:
            configureNavigate()
        case .call:
            configureCall()
        case .github:
            configureGitHub()
        case .linkedIn:
            configureLinkedIn()
        case .none:
            print("Error: No PAButtonStyle")
        }
    }
    
    
    private func configureNavigate(){
        self.setImage(UIImage(systemName: SFSymbols.nav.rawValue), for: .normal)
        
    }
    
    
    private func configureCall(){
        self.setImage(UIImage(systemName: SFSymbols.phone.rawValue), for: .normal)
    }
    
    
    private func configureGitHub(){
        configureConstraints()
        self.setImage(UIImage(named: "gitHub"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    
    private func configureLinkedIn(){
        configureConstraints()
        self.setImage(UIImage(named: "linkedIn"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    
    //Used with custom images (for re-sizing purposes) as opposed to SFsymbols (those juse get messed up by manual constraints).
    private func configureConstraints(){
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView!.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            imageView!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            imageView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            imageView!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
    
    
}
