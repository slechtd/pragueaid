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
    
    convenience init(infoProperty: InfoSectionCellContent){
        self.init()
        textLabel?.text = infoProperty.content
        imageView?.image = UIImage(systemName: infoProperty.icon.rawValue)
        action = infoProperty.action
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
