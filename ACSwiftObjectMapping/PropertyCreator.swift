//
//  PropertyCreator.swift
//  ACSwiftObjectMapping
//
//  Created by Aras Cagli on 20.09.2016.
//  Copyright © 2016 Aras Cagli. All rights reserved.
//

import Foundation

class PropertyCreator{

    static func createArrayDictionaryProperties(objectStr: String, keyValue: String, classStr: String, constantValue: String, classType: String) -> String{
    
        var changeStr = classStr
        var dictStr = objectStr
        dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
        dictStr = Helper.replaceText(orginalText: dictStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
        changeStr = Helper.replaceText(orginalText: classStr, ofString: constantValue, witString: dictStr)
        changeStr = self.createPropertyGetter(keyValue: keyValue, className: classType, classString: changeStr)
        return changeStr
    }
    
    static func createObjectArray(objectStr: String, keyValue: String, objType: String, classStr: String, constantValue: String, classType: String) -> String{
        
        var changeStr = classStr
        var dictStr = objectStr
        dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
        dictStr = Helper.replaceText(orginalText: dictStr, ofString: typeName, witString: objType)
        changeStr = Helper.replaceText(orginalText: classStr, ofString: constantValue, witString: dictStr)
        changeStr = self.createPropertyGetter(keyValue: keyValue, className: classType, classString: changeStr)
        return changeStr
    }
    
    static func createObjectProperties(objectStr: String, keyValue: String, classStr: String, constantValue: String, classType: String) -> String {
        
        var changeStr = classStr
        var dictStr = objectStr
        dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
        changeStr = Helper.replaceText(orginalText: changeStr, ofString: constantValue, witString: dictStr)
        changeStr = self.createPropertyGetter(keyValue: keyValue, className: classType, classString: changeStr)
        return changeStr
    }
    
    private static func createPropertyGetter(keyValue: String, className: String, classString : String) -> String
    {
        
        var changeStr = classString
        var getterStr = getterType
        getterStr = Helper.replaceText(orginalText: getterStr, ofString: objectName, witString: keyValue)
        getterStr = Helper.replaceText(orginalText: getterStr, ofString: clazzName, witString: className)
        changeStr = Helper.replaceText(orginalText: changeStr, ofString: "propertyGetter", witString: getterStr)
        return changeStr
    }    
}
