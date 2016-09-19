//
//  ViewController.swift
//  ACSwiftObjectMapping
//
//  Created by Aras Cagli on 13.09.2016.
//  Copyright © 2016 Aras Cagli. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    
    
    
    @IBOutlet weak var txtClassName: NSTextField!
    @IBOutlet var txtJson: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func mapPressed(sender: AnyObject) {
        
        // Get Json
        let jsonText = txtJson.textStorage?.string
        let objectData = jsonText!.data(using: String.Encoding.utf8)
        let json:NSDictionary = try! JSONSerialization.jsonObject(with: objectData!, options:JSONSerialization.ReadingOptions.mutableContainers)as! NSDictionary
        
        // Determine Object Types
        let objectList = getObjectLists(dictList: json)
        var objectsDict = objectList.objectsDict
        var innerObjectDict = objectList.innerObjectDict
        
        // Create Base Class
        let classCreator = ClassCreator()
        let classText = classCreator.createClass(objectsDict: objectsDict, className: txtClassName.stringValue.capitalizingFirstLetter())
        
        // file yazdır
       // print(classText)
        let url = SystemIO.createClass(text: classText, fileURL: nil, className: txtClassName.stringValue.capitalizingFirstLetter(), isCreateWithFolder: true)
        
        // Inner Dictionaries
        while innerObjectDict.count > 0 {
           
            for (key, value) in innerObjectDict{
                let objectList = getObjectLists(dictList: value as NSDictionary)
                objectsDict = objectList.objectsDict
                let innerDict = objectList.innerObjectDict
                innerObjectDict.removeValue(forKey: "\(key)")
                
                if innerDict.count > 0 {
                    for (keyInner, valueInner) in innerDict{
                        innerObjectDict["\(keyInner)"] = valueInner
                    }
                }
                
                
                let classCreator = ClassCreator()
                let classText = classCreator.createClass(objectsDict: objectsDict, className: "\(key.capitalizingFirstLetter())")
                
                // file yazdır
                print(classText)
                SystemIO.createClass(text: classText, fileURL: url, className: key.capitalizingFirstLetter(), isCreateWithFolder: false)
            }
            
        }
        
    }
    
    private func getObjectLists(dictList: NSDictionary) -> (objectsDict:[String: Type], innerObjectDict: [String: [String: Any]])
    {
        var objectsDict = [String: Type]()
        var classObjectDict = [String: [String: Any]]()
        
        for (key, value) in dictList {
            var innerObjects = [String: Any]()
            print("key: \(key) value: \(value) type: \(type(of: value))")
            let objectType = getObjectType(value: value)
            objectsDict["\(key)"] = objectType
            
            if objectType == Type.dictionaryObject{
                for (innerKey, innerValue) in value as! NSDictionary {
                    innerObjects["\(innerKey)"] = innerValue
                    classObjectDict["\(key)"] = innerObjects
                    print(classObjectDict)
                }
            } else if (objectType == Type.classArrayObject){
                if let array = dictList["\(key)"] as? NSArray,
                    let item = array[0] as? [String: Any]{
                    classObjectDict["\(key)"] = item
                }
            }
        }
        
        return(objectsDict, classObjectDict)
    }
    
    private func getObjectType(value: Any) -> Type{
     
        let type = "\(type(of: value))"
        if type.range(of: "String") != nil{
            return Type.stringObject
        }
        else if (type.range(of: "Boolean") != nil){
            return Type.boolObject
        }
        else if (type.range(of: "Dictionary") != nil){
            return Type.dictionaryObject
        }
        else if (type.range(of: "Number") != nil){
            return getNumericType(value: "\(value)")
        }
        else if (type.range(of: "Array") != nil){
            return getArrayType(value: value)
        }
        
        return Type.nullObject
    }
    
    private func getNumericType(value: String) -> Type{
        print(value)
    
        if (value.range(of: ".") != nil){
            return Type.doubleObject
        }else
        {
            return Type.intObject
        }
        
    }
    
    private func getArrayType(value: Any) -> Type{
        
        if value is [String] {
            return Type.stringArrayObject
        }
        else if value is [NSNumber] {
            return Type.intArrayObject
        }
        else
        {
            return Type.classArrayObject
        }
    
    }
    
}
