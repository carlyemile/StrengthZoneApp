//
//  ManagedPhoto+CoreDataClass.swift
//  
//
//  Created by Admin on 5/6/18.
//
//

import Foundation
import CoreData

@objc(ManagedPhoto)
public class ManagedPhoto: NSManagedObject {
    public func customFuncGetImage() -> NSData {
        return image!
    }
    
    public func customFuncGetDate() -> String {
        return date!
    }
}
