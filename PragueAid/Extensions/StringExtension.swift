//
//  StringExtension.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 27/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

extension String {
    
    func dropFirstWhitespace() -> String {
        if self.prefix(1) == " " {
            return String(self.dropFirst())
        } else {
            return self
        }
    }
    
    
    func shortenUrl() -> String {
        if self.dropFirstWhitespace().prefix(11) == "http://www." || self.dropFirstWhitespace().prefix(11) == "http//:www."  {
            return String(self.dropFirstWhitespace().dropFirst(11))
        } else if self.dropFirstWhitespace().prefix(11) == "https://www." || self.dropFirstWhitespace().prefix(11) == "https//:www."{
            return String(self.dropFirstWhitespace().dropFirst(12))
        } else {
            return self
        }
    }
}

