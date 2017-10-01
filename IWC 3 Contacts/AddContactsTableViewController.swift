//
//  AddContactsTableViewController.swift
//  IWC 3 Contacts
//
//  Created by Arifin Firdaus on 8/9/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import UIKit


enum EditingType {
    case add
    case edit
}

class AddContactsTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    
    var provider = PhoneBookDataAccessProvider()
    var phonebookDataIndex = -1
    
    struct AddContactsStoryboard {
        static let AddContactsTableViewNavigationControllerId = "AddContactsTableViewNavigationController"
        static let AddContactsTableViewControllerId = "AddContactsTableViewController"
    }
    
    var editingType: EditingType = .add
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    
    
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editingType == .add {
            self.title = "Add"
        } else {
            title = "Edit"
            updateUI()
        }
    }

    
    private func updateUI() {
        if let data = provider.fetchPhoneBokkData(withIndex: phonebookDataIndex) {
            tfName.text = data.name
            tfPhoneNumber.text = data.number
        }
    }
    
    
    // MARK: - @IBAction
    
    @IBAction func cancelDidTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneDidTapped(_ sender: UIBarButtonItem) {
        
        guard let name = tfName.text, let phoneNumber = tfPhoneNumber.text else { return }
        
        if editingType == .add {
            self.title = "Add"
            addData(name: name, phoneNumber: phoneNumber)
        } else {
            title = "Edit"
            updateUI()
            print(editData(withIndex: phonebookDataIndex,name: name,phoneNumber: phoneNumber))
        }
        
        
    }
    
    func editData(withIndex index: Int, name: String, phoneNumber: String) -> Bool {
        dismiss(animated: true, completion: nil)
        return provider.editPhobookData(withIndex: index, newName: name, newNumber: phoneNumber)
    }
    
    func addData(name: String, phoneNumber: String) {
        // save to code data
        let isSuccess = provider.addPhoneBookData(name: name, number: phoneNumber)
        print(isSuccess)
        dismiss(animated: true, completion: nil)
    }
    
    
}
