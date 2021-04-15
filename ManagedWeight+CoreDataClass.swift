//
//  ManagedWeight+CoreDataClass.swift
//  
//
//  Created by Admin on 5/6/18.
//
//

import Foundation
import CoreData

@objc(ManagedWeight)
public class ManagedWeight: NSManagedObject {
    public func customFuncGetWeight() -> Int {
        return weight!
    }
    
    public func customFuncGetDate() -> String {
        return date!
    }
}
