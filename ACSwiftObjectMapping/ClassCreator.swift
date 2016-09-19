//
//  ClassCreator.swift
//  ACSwiftObjectMapping
//
//  Created by Aras Cagli on 17.09.2016.
//  Copyright © 2016 Aras Cagli. All rights reserved.
//

import Foundation

class ClassCreator {
    
    func createClass(objectsDict: [String: Type], className: String) -> String{
        // Read Template File
        let url = SystemIO.getURL()
        var classText = SystemIO.readFile(fileURL: url)
        
        for (key, value) in objectsDict{
            classText = self.createProperties(keyValue:key, objecType: value, classString: classText)
            classText = self.fillInitFunc(keyValue: key, objecType: value, classString: classText)
            classText = self.fillDocumantPresentation(keyValue:key, objecType: value, classString: classText)
        }
        
        classText = replaceText(orginalText: classText, ofString: "ClassName", witString: className)
        
        return self.clearTemplateConstants(orginalText: classText)
    }
    
    private func createProperties(keyValue: String, objecType:Type, classString : String) -> String
    {
        var changeStr = classString
        
        switch objecType {
            
        case Type.dictionaryObject:
            
            var dictStr = dictionaryType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue, className: keyValue.capitalizingFirstLetter(), classString: changeStr)
            break
            
        case Type.classArrayObject:
            
            var dictStr = classArrayType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue, className: "Array<\(keyValue.capitalizingFirstLetter())>", classString: changeStr)
            break
            
        case Type.stringArrayObject:
            
            var dictStr = objectArrayType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            dictStr = replaceText(orginalText: dictStr, ofString: typeName, witString: "String")
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue, className: "Array<String>", classString: changeStr)
            break
            
        case Type.intArrayObject:
            
            var dictStr = objectArrayType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            dictStr = replaceText(orginalText: dictStr, ofString: typeName, witString: "Int")
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue, className: "Array<Int>", classString: changeStr)
            break
            
        case Type.boolObject:
            
            var dictStr = boolType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue, className: "Bool", classString: changeStr)
            break
            
        case Type.doubleObject:
            
            var dictStr = doubleType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue, className: "Double", classString: changeStr)
            break
            
        case Type.stringObject:
            
            var dictStr = stringType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue, className: "String", classString: changeStr)
            break
            
        case Type.intObject:
            
            var dictStr = intType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue.addUnderScore())
            changeStr = replaceText(orginalText: changeStr, ofString: "properties", witString: dictStr)
            changeStr = createPropertyGetter(keyValue: keyValue,className: "Int", classString: changeStr)
            break
            
        default:
            break
        }
        
        return changeStr
    }
    
    private func createPropertyGetter(keyValue: String, className: String, classString : String) -> String
    {
        
        var changeStr = classString
        var getterStr = getterType
        getterStr = replaceText(orginalText: getterStr, ofString: objectName, witString: keyValue)
        getterStr = replaceText(orginalText: getterStr, ofString: clazzName, witString: className)
        changeStr = replaceText(orginalText: changeStr, ofString: "propertyGetter", witString: getterStr)
        return changeStr
    }
    
    private func fillInitFunc(keyValue: String, objecType:Type, classString : String) -> String
    {
    
        var changeStr = classString
        
        switch objecType {
            
        case Type.dictionaryObject:
            
            var dictStr = initDictionaryType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.classArrayObject:
            
            var dictStr = initClassArrayType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.stringArrayObject:
            
            var dictStr = initObjectArrayType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.intArrayObject:
            
            var dictStr = initObjectArrayType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.boolObject:
            
            var dictStr = initCoreType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: "Bool")
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.doubleObject:
            
            var dictStr = initCoreType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: "Double")
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.stringObject:
            
            var dictStr = initCoreType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: "String")
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.intObject:
            
            var dictStr = initCoreType
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = replaceText(orginalText: dictStr, ofString: clazzName, witString: "Int")
            changeStr = replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        default:
            break
        }
        
        return changeStr
    }
    
    private func fillDocumantPresentation(keyValue: String, objecType:Type, classString : String) -> String
    {
        var changeStr = classString
        
        switch objecType {
            
        case Type.dictionaryObject:
            var dictStr = docPresDocumant
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = replaceText(orginalText: changeStr, ofString: "dictionaryInside", witString: dictStr)
            break
        
        case Type.classArrayObject:
            break
            
        case Type.stringArrayObject:
            break
            
        case Type.doubleArrayObject:
            break
            
        case Type.floatArrayObject:
            break
            
        case Type.intArrayObject:
            break
            
        default:
            var dictStr = docPresObject
            dictStr = replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = replaceText(orginalText: changeStr, ofString: "dictionaryInside", witString: dictStr)
            break
        }
        
        return changeStr

    }
    
    private func clearTemplateConstants(orginalText: String) -> String{
        
        var str = orginalText
        str = replaceText(orginalText: str, ofString: "properties", witString: "")
        str = replaceText(orginalText: str, ofString: "propertyGetter", witString: "")
        str = replaceText(orginalText: str, ofString: "initInside", witString: "")
        str = replaceText(orginalText: str, ofString: "dictionaryInside", witString: "")
        return str
    }
    
    private func replaceText(orginalText: String, ofString : String, witString : String) -> String{
        
        var str = orginalText
        str = str.replacingOccurrences(of: ofString, with: witString)
        return str
    }
}
