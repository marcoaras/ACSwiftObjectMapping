//
//  String+Ext.swift
//  ACSwiftObjectMapping
//
//  Created by Aras Cagli on 17.09.2016.
//  Copyright © 2016 Aras Cagli. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func addUnderScore() -> String{
        return "_" + self
    }
    
    func isNumber() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
}
