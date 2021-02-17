//
//  PAFooterView.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit

class PAFooterView: UIView {
    
    let label = PASecondaryLabel()
    let imageView = UIImageView()
    
    var message: String?
    var image: UIImage?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(frame: CGRect, message: String){
        self.init(frame: frame)
        self.message = message
        configureTitleLabel()
    }
    
    
    convenience init(frame: CGRect, image: UIImage){
        self.init(frame: frame)
        self.image = image
        configureImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTitleLabel(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            label.widthAnchor.constraint(equalToConstant: self.frame.width * 0.9)
        ])
    }
    
    
    private func configureImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            imageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.9)
        ])
    }
}
