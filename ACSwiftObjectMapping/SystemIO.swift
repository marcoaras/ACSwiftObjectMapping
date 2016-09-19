//
//  SystemIO.swift
//  ACSwiftObjectMapping
//
//  Created by Aras Cagli on 17.09.2016.
//  Copyright © 2016 Aras Cagli. All rights reserved.
//

import Foundation

public class SystemIO {
    
    static func getURL() -> URL{
        
        let fileURL = Bundle.main.url(forResource: "template", withExtension: "")!
       // print("File path: \(fileURL)")
        return fileURL
        
    }
    
    static func createFolder(folderName : String) -> URL{
        
        let desktopUrl = FileManager().urls(for: .desktopDirectory, in: .userDomainMask).first
        let folderDestinationUrl = desktopUrl?.appendingPathComponent("\(folderName)")
        do{
            try FileManager().createDirectory(atPath: (folderDestinationUrl?.path)!, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError
        {
            print("Error while creating a file: \(error.description)")
        }
            return folderDestinationUrl!
    }
    
    static func readFile(fileURL : URL) -> String{
        
        // Reading from a file on disk
        var inString = ""
        do {
            inString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        print("Read from file: \(inString)")
        
        
        return inString
    }
    
    static func writeFile(fileURL : URL, text : String){
        
        // Write to a file on disk
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    static func createClass(text : String, fileURL : URL?, className : String?, isCreateWithFolder : Bool) -> URL
    {
        var url: URL
        var retUrl : URL
        if isCreateWithFolder {
            url = SystemIO.createFolder(folderName: className!)
            retUrl = url
            url = url.appendingPathComponent(className!).appendingPathExtension("swift")
        } else {
            url = (fileURL?.appendingPathComponent(className!).appendingPathExtension("swift"))!
            retUrl = url
        }
        
        writeFile(fileURL: url, text: text)
        return retUrl
    }
}
