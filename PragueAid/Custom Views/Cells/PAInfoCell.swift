//
//  PAInfoCell.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit


class PAInfoCell: UITableViewCell {
    
    var action: CellAction = .none
    var toggle: UISwitch?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.tintColor = .systemRed
    }
    
    
    convenience init(content: String, imageString: String, toggle: Bool = false){
        self.init()
        textLabel?.text = content
        imageView?.image = UIImage(systemName: imageString)
        if toggle == true {configureToggle()}
    }
    
    
    convenience init(cellContent: InfoSectionCellContent){
        self.init()
        
        imageView?.image = UIImage(systemName: cellContent.icon.rawValue)
        action = cellContent.action
        
        if cellContent.textLine2 == nil || cellContent.textLine2 == "" {
            textLabel?.numberOfLines = 1
            textLabel?.text = cellContent.textLine1
        } else {
            textLabel?.numberOfLines = 2
            textLabel?.text = "\(cellContent.textLine1)\n\(cellContent.textLine2!)"
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureToggle(){
        toggle = UISwitch()
        toggle?.onTintColor = .systemRed
        addSubview(toggle!)
        toggle?.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            toggle!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            toggle!.heightAnchor.constraint(equalToConstant: 32),
            toggle!.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            toggle!.widthAnchor.constraint(equalToConstant: 65) //test value
        ])
        
    }

}
