//
//  StringExtension.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 27/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

extension String {
    
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localized", bundle: .main, value: self, comment: self)
    }
    
    
    func dropFirstSpace() -> String {
        if self.prefix(1) == " " {
            return String(self.dropFirst())
        } else {
            return self
        }
    }
    
    
    func removeAllSpaces() -> String {
        return self.replacingOccurrences(of: "\\s*", with: "$1", options: [.regularExpression])
    }
    
    
    func shortenUrl() -> String {
        if self.removeAllSpaces().prefix(11) == "http://www." || self.removeAllSpaces().prefix(11) == "http//:www."  {
            return String(self.removeAllSpaces().dropFirst(11))
        } else if self.removeAllSpaces().prefix(12) == "https://www." || self.removeAllSpaces().prefix(12) == "https//:www."{
            return String(self.removeAllSpaces().dropFirst(12))
        } else {
            return self
        }
    }
    
    
    func formatPhoneNumber() -> String {
        //remove all non-numeric chars
        let phoneNumber = String(self.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil })
        //remove 420
        if phoneNumber.prefix(3) == "420" {
            return String(phoneNumber.removeAllSpaces().dropFirst(3))
        } else {
            return phoneNumber
        }
    }
}



/*if self.dropFirstSpace().prefix(4) == "+420" {
 return String(self.removeAllSpaces().dropFirst(4))
} else {
 return String(self.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil })
}
}*/
