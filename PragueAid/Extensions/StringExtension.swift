//
//  StringExtension.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 27/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

extension String {
    
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
    
    #warning("nekde nefunguje + to same foun atd")
    func shortenUrl() -> String {
        if self.removeAllSpaces().prefix(11) == "http://www." || self.removeAllSpaces().prefix(11) == "http//:www."  {
            return String(self.removeAllSpaces().dropFirst(11))
        } else if self.removeAllSpaces().prefix(11) == "https://www." || self.removeAllSpaces().prefix(11) == "https//:www."{
            return String(self.removeAllSpaces().dropFirst(12))
        } else {
            return self
        }
    }
}

