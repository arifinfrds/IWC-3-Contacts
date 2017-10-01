//
//  PhoneBookDataAccessProvider.swift
//  IWC 3 Contacts
//
//  Created by Arifin Firdaus on 8/9/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct PhoneBookDataAccessProvider {
    
    
    // MARK: - Properties
    
    private var appDelegate: AppDelegate!
    private var managedObjectContext: NSManagedObjectContext!
    
    
    // MARK: - Init
    
    init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    
    // MARK: - Public API's
    
    func fetchPhoneBookData() -> [PhoneBookData] {
        let request = PhoneBookData.PhoneBookfetchRequest()
        
        // untuk debugging
        request.returnsObjectsAsFaults = false
        
        do {
            return try managedObjectContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchPhoneBokkData(withIndex index: Int) -> PhoneBookData? {
        let allData = fetchPhoneBookData()
        
        if index < 0 || index > allData.count - 1 {
            return nil
        }
        return fetchPhoneBookData()[index]
    }
    
    func addPhoneBookData(name: String, number: String) -> Bool {
        let newPhoneBookData = NSEntityDescription.insertNewObject(forEntityName: "PhoneBookData", into: managedObjectContext) as! PhoneBookData
        
        newPhoneBookData.name = name
        newPhoneBookData.number = number
        
        do {
            try managedObjectContext.save()
            return true
        } catch {
            return false
        }
    }
    
    func editPhobookData(withIndex index: Int, newName: String, newNumber: String) -> Bool {
        if let data = fetchPhoneBookData()[index] as? PhoneBookData {
            data.name = newName
            data.number = newNumber
            
            do {
                try managedObjectContext.save()
                return true
            } catch {
                return false
            }
            
        }
    }
    
    func deletePhoneBookData(index: Int) -> Bool {
        var isSuccessDelete = false
        
        // dapetin data
        let data = fetchPhoneBookData()
        
        data.enumerated().forEach { (i, element) in
            
            if i == index {
                managedObjectContext.delete(element)
                do {
                    try managedObjectContext.save()
                    isSuccessDelete = true
                } catch  {
                    isSuccessDelete = false
                }
            }
        }
        
        //        // cara lain
        //        for (i, element) in data.enumerated() {
        //            if i == index {
        //                managedObjectContext.delete(element)
        //                do {
        //                    try managedObjectContext.save()
        //                    isSuccessDelete = true
        //                } catch  {
        //                    isSuccessDelete = false
        //                }
        //            }
        //        }
        return isSuccessDelete
    }
    
    
    
}
