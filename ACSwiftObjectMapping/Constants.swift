//
//  Constants.swift
//  ACSwiftObjectMapping
//
//  Created by Aras Cagli on 17.09.2016.
//  Copyright © 2016 Aras Cagli. All rights reserved.
//

enum Type {
    case stringObject
    case intObject
    case boolObject
    case doubleObject
    case dictionaryObject
    case classArrayObject
    case stringArrayObject
    case intArrayObject
    case doubleArrayObject
    case floatArrayObject
    case nullObject
}
// Helper Constants
let objectName = "objectName"
let clazzName = "className"
let typeName = "typeName"

// Properties
let dictionaryType = "private var objectName : className? \r\n\tproperties"
let classArrayType = "private var objectName : Array<className>? \r\n\tproperties"
let objectArrayType = "private var objectName : Array<typeName>? \r\n\tproperties"
let intType = "private var objectName : Int? \r\n\tproperties"
let doubleType = "private var objectName : Double? \r\n\tproperties"
let boolType = "private var objectName : Bool? \r\n\tproperties"
let stringType = "private var objectName : String? \r\n\tproperties"

// Getter
//let getterType = "var objectName : className {\r\n\t\treturn _objectName!\r\n\t}\r\n\r\n\tpropertyGetter"
let getterType = "var objectName : className \r\n\t{\r\n\t\tget{\r\n\t\t\treturn _objectName!\r\n\t\t}set{\r\n\t\t\t_objectName = newValue\r\n\t\t}\r\n\t}\r\n\r\n\tpropertyGetter"

// Init Functions
let initDictionaryType = "if (dictionary[\"objectName\"] != nil) { _objectName = className(dictionary: dictionary[\"objectName\"] as! NSDictionary) } \r\n\t\tinitInside"
let initClassArrayType = "if (dictionary[\"objectName\"] != nil) { _objectName = className.modelsFromDictionaryArray(array: dictionary[\"objectName\"] as! NSArray) } \r\n\t\tinitInside"
let initObjectArrayType = "if (dictionary[\"objectName\"] != nil) { _objectName = dictionary[\"objectName\"] as! NSArray } \r\n\t\tinitInside"
let initCoreType = "_objectName = dictionary[\"objectName\"] as? className \r\n\t\tinitInside"

let initParams = "objectName: className initParams"
let initInsideWithparams = "_objectName = objectName\r\n\t\tinitWithParams"

// documentPresentation
let docPresObject = "dictionary.setValue(self._objectName, forKey: \"objectName\")\r\n\t\tdictionaryInside"
let docPresDocumant = "dictionary.setValue(self._objectName?.dictionaryRepresentation(), forKey: \"objectName\")\r\n\t\tdictionaryInside"
