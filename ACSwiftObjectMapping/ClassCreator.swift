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
            classText = self.fillInitWithParams(keyValue: key, objecType: value, classString: classText)
            classText = self.fillDocumantPresentation(keyValue:key, objecType: value, classString: classText)
        }
        
        classText = Helper.replaceText(orginalText: classText, ofString: "ClassName", witString: className)
        
        return self.clearTemplateConstants(orginalText: classText)
    }
    
    private func createProperties(keyValue: String, objecType:Type, classString : String) -> String
    {
        var changeStr = classString
        var properties = "properties"
        switch objecType {
            
        case Type.dictionaryObject:
            
            changeStr = PropertyCreator.createArrayDictionaryProperties(objectStr: dictionaryType, keyValue: keyValue, classStr: changeStr, constantValue: properties, classType: keyValue.capitalizingFirstLetter())
            break
            
        case Type.classArrayObject:
            
            changeStr = PropertyCreator.createArrayDictionaryProperties(objectStr: classArrayType, keyValue: keyValue, classStr: changeStr, constantValue: properties, classType: "Array<\(keyValue.capitalizingFirstLetter())>")
            break
            
        case Type.stringArrayObject:
            
            changeStr = PropertyCreator.createObjectArray(objectStr: objectArrayType, keyValue: keyValue, objType: "String", classStr: changeStr, constantValue: properties, classType: "Array<String>")
            break
            
        case Type.intArrayObject:
            
            changeStr = PropertyCreator.createObjectArray(objectStr: objectArrayType, keyValue: keyValue, objType: "Int", classStr: changeStr, constantValue: properties, classType: "Array<Int>")
            break
            
        case Type.boolObject:
            
            changeStr = PropertyCreator.createObjectProperties(objectStr: boolType, keyValue: keyValue, classStr: changeStr, constantValue: properties, classType: "Bool")
            break
            
        case Type.doubleObject:
            
            changeStr = PropertyCreator.createObjectProperties(objectStr: doubleType, keyValue: keyValue, classStr: changeStr, constantValue: properties, classType: "Double")
            break
            
        case Type.stringObject:
            
            changeStr = PropertyCreator.createObjectProperties(objectStr: stringType, keyValue: keyValue, classStr: changeStr, constantValue: properties, classType: "String")
            break
            
        case Type.intObject:
            
            changeStr = PropertyCreator.createObjectProperties(objectStr: intType, keyValue: keyValue, classStr: changeStr, constantValue: properties, classType: "Int")
            break
            
        default:
            break
        }
        
        return changeStr
    }
    
   
    
    private func fillInitFunc(keyValue: String, objecType:Type, classString : String) -> String
    {
    
        var changeStr = classString
        
        switch objecType {
            
        case Type.dictionaryObject:
            
            var dictStr = initDictionaryType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.classArrayObject:
            
            var dictStr = initClassArrayType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.stringArrayObject:
            
            var dictStr = initObjectArrayType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.intArrayObject:
            
            var dictStr = initObjectArrayType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.boolObject:
            
            var dictStr = initCoreType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: clazzName, witString: "Bool")
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.doubleObject:
            
            var dictStr = initCoreType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: clazzName, witString: "Double")
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.stringObject:
            
            var dictStr = initCoreType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: clazzName, witString: "String")
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        case Type.intObject:
            
            var dictStr = initCoreType
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: clazzName, witString: "Int")
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initInside", witString: dictStr)
            break
            
        default:
            break
        }
        
        return changeStr
    }
    
    private func fillInitWithParams(keyValue: String, objecType:Type, classString : String) -> String{
    
        var changeStr = classString
       
        switch objecType {
            
        case Type.dictionaryObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: keyValue.capitalizingFirstLetter())
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            
            
            break
            
        case Type.classArrayObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: "Array<\(keyValue.capitalizingFirstLetter())>")
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            break
            
        case Type.stringArrayObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: "Array<String>")
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            
            break
            
        case Type.intArrayObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: "Array<Int>")
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            
            break
            
        case Type.boolObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: "Bool")
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            
            break
            
        case Type.doubleObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: "Double")
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            
            break
            
        case Type.stringObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: "String")
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            
            break
            
        case Type.intObject:
            
            var paramStr = initParams
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: objectName, witString: keyValue)
            paramStr = Helper.replaceText(orginalText: paramStr, ofString: clazzName, witString: "Int")
            if changeStr.contains("initFirstParams"){
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initFirstParams", witString: paramStr)
            } else {
                changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initParams", witString: ",\(paramStr)")
            }
            
            break
            
        default:
            break
        }
        
        var insideWithparams = initInsideWithparams
        insideWithparams = Helper.replaceText(orginalText: insideWithparams, ofString: objectName, witString: keyValue)
        changeStr = Helper.replaceText(orginalText: changeStr, ofString: "initWithParams", witString: insideWithparams)
        
        return changeStr
    }
    
    private func fillDocumantPresentation(keyValue: String, objecType:Type, classString : String) -> String
    {
        var changeStr = classString
        
        switch objecType {
            
        case Type.dictionaryObject:
            var dictStr = docPresDocumant
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "dictionaryInside", witString: dictStr)
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
            dictStr = Helper.replaceText(orginalText: dictStr, ofString: objectName, witString: keyValue)
            changeStr = Helper.replaceText(orginalText: changeStr, ofString: "dictionaryInside", witString: dictStr)
            break
        }
        
        return changeStr

    }
    
    private func clearTemplateConstants(orginalText: String) -> String{
        
        var str = orginalText
        str = Helper.replaceText(orginalText: str, ofString: "properties", witString: "")
        str = Helper.replaceText(orginalText: str, ofString: "propertyGetter", witString: "")
        str = Helper.replaceText(orginalText: str, ofString: "initInside", witString: "")
        str = Helper.replaceText(orginalText: str, ofString: "dictionaryInside", witString: "")
        str = Helper.replaceText(orginalText: str, ofString: "initParams", witString: "")
        str = Helper.replaceText(orginalText: str, ofString: "initWithParams", witString: "")
        
        return str
    }
    
   
}
