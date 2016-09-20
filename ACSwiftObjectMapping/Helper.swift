//
//  StringHelper.swift
//  ACSwiftObjectMapping
//
//  Created by Aras Cagli on 20.09.2016.
//  Copyright © 2016 Aras Cagli. All rights reserved.
//

import Foundation

class Helper{

    static func replaceText(orginalText: String, ofString : String, witString : String) -> String{
        
        var str = orginalText
        str = str.replacingOccurrences(of: ofString, with: witString)
        return str
    }
}
