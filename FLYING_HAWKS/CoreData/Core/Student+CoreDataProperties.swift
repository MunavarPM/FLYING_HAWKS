//
//  Student+CoreDataProperties.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var place: String?
    @NSManaged public var id: UUID?
    @NSManaged public var photo: Data?

}

extension Student : Identifiable {

}
