//
//  StringExtension.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 27/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

extension String {
    
    
    //Return a localized version of self as per Localized.strings
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localized", bundle: .main, value: self, comment: self)
    }
    
    
    func removeAllSpaces() -> String {
        return self.replacingOccurrences(of: "\\s*", with: "$1", options: [.regularExpression])
    }
    
    
    //Done to straighten non-standard and weird URL formats fetched from the API.
    func formatURL() -> String {
        var url = self.removeAllSpaces()
        //remove random colons at the beginning
        if url.prefix(1) == ":" { url = String(url.dropFirst()) }
        //remove subdomain
        if url.prefix(4) == "www." { url = String(url.dropFirst(4)) }
        //remove 11 char long of protocols and subdomains, including weird cases
        if url.prefix(11) == "http://www." || url.prefix(11) == "http//:www." { url = String(url.dropFirst(11)) }
        //remove 12 char long of protocols and subdomains, including weird cases
        if url.prefix(12) == "https://www." || url.prefix(12) == "https//:www." { url = String(url.dropFirst(12)) }
        return url
    }
    
    
    //Done to straighten non-standard and weird phone number formats fetched from the API.
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

