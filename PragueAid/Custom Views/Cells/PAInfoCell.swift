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
    
    convenience init(content: String, imageString: String){
        self.init()
        textLabel?.text = content
        imageView?.image = UIImage(systemName: imageString)
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

}
