//
//  PhoneBookData+CoreDataProperties.swift
//  IWC 3 Contacts
//
//  Created by Arifin Firdaus on 8/9/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import Foundation
import CoreData


extension PhoneBookData {

    @nonobjc public class func PhoneBookfetchRequest() -> NSFetchRequest<PhoneBookData> {
        return NSFetchRequest<PhoneBookData>(entityName: "PhoneBookData")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?

}
