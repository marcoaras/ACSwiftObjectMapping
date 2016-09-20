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
        
        let properties = "properties"
        var changeStr = classString
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
    
        let initInside = "initInside"
        var changeStr = classString
        
        switch objecType {
            
        case Type.dictionaryObject:
            
            changeStr = InitFuncCreator.createInitFuncwithDict(objectStr: initDictionaryType, keyValue: keyValue, classStr: changeStr, constantValue: initInside, classType: keyValue.capitalizingFirstLetter())
            break
            
        case Type.classArrayObject:
            
            changeStr = InitFuncCreator.createInitFuncwithDict(objectStr: initClassArrayType, keyValue: keyValue, classStr: changeStr, constantValue: initInside, classType: keyValue.capitalizingFirstLetter())
            break
            
        case Type.stringArrayObject:
            
            changeStr = InitFuncCreator.createInitFuncWithArray(objectStr: initObjectArrayType, keyValue: keyValue, classStr: changeStr, constantValue: initInside)
            break
            
        case Type.intArrayObject:
            
            changeStr = InitFuncCreator.createInitFuncWithArray(objectStr: initObjectArrayType, keyValue: keyValue, classStr: changeStr, constantValue: initInside)
            break
            
        case Type.boolObject:
            
            changeStr = InitFuncCreator.createInitFuncwithDict(objectStr: initCoreType, keyValue: keyValue, classStr: changeStr, constantValue: initInside, classType: "Bool")
            break
            
        case Type.doubleObject:
            
            changeStr = InitFuncCreator.createInitFuncwithDict(objectStr: initCoreType, keyValue: keyValue, classStr: changeStr, constantValue: initInside, classType: "Double")
            break
            
        case Type.stringObject:
            
            changeStr = InitFuncCreator.createInitFuncwithDict(objectStr: initCoreType, keyValue: keyValue, classStr: changeStr, constantValue: initInside, classType: "String")
            break
            
        case Type.intObject:
            
            changeStr = InitFuncCreator.createInitFuncwithDict(objectStr: initCoreType, keyValue: keyValue, classStr: changeStr, constantValue: initInside, classType: "Int")
            break
            
        default:
            break
        }
        
        return changeStr
    }
    
    private func fillInitWithParams(keyValue: String, objecType:Type, classString : String) -> String{
    
        let cInitParams = "initParams"
        var changeStr = classString
       
        switch objecType {
            
        case Type.dictionaryObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: keyValue.capitalizingFirstLetter())
            break
            
        case Type.classArrayObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: "Array<\(keyValue.capitalizingFirstLetter())>")
            break
            
        case Type.stringArrayObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: "Array<String>")
            break
            
        case Type.intArrayObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: "Array<Int>")
            break
            
        case Type.boolObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: "Bool")
            break
            
        case Type.doubleObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: "Double")
            break
            
        case Type.stringObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: "String")
            break
            
        case Type.intObject:
            
            changeStr = InitFuncCreator.createInitWithParams(objectStr: initParams, keyValue: keyValue, classStr: changeStr, constantValue: cInitParams, classType: "Int")
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
