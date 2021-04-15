//
//  ManagedPhoto+CoreDataProperties.swift
//  
//
//  Created by Admin on 5/6/18.
//
//

import Foundation
import CoreData


extension ManagedPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedPhoto> {
        return NSFetchRequest<ManagedPhoto>(entityName: "ManagedPhoto")
    }

    @NSManaged public var date: String?
    @NSManaged public var image: NSData?

}
