//
//  ManagedWeight+CoreDataProperties.swift
//  
//
//  Created by Admin on 5/6/18.
//
//

import Foundation
import CoreData


extension ManagedWeight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedWeight> {
        return NSFetchRequest<ManagedWeight>(entityName: "ManagedWeight")
    }

    @NSManaged public var date: String?
    @NSManaged public var weight: Int16

}
