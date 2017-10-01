//
//  ViewController.swift
//  IWC 3 Contacts
//
//  Created by Arifin Firdaus on 8/9/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    
    // MARK: - Properties
    
    struct ContactsStoryboard {
        static let contactsCellId = "contact_cell"
    }
    
    @IBOutlet var contactTableView: UITableView!
    
    var phoneBookData = [PhoneBookData]()
    var provider = PhoneBookDataAccessProvider()
    
    var name: String!
    var phoneNumber: String!
    
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshPhoneBookData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactTableView.dataSource = self
        contactTableView.delegate = self
        
        setupViews()
    }
    
    func setupViews() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    fileprivate func refreshPhoneBookData() {
        phoneBookData = provider.fetchPhoneBookData()
        contactTableView.reloadData()
        
        print("jumlah kontak : \(phoneBookData.count)")
    }
    
}


// MARK: - UITableViewDataSource

extension ContactsViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsStoryboard.contactsCellId, for: indexPath)
        cell.textLabel?.text = phoneBookData[indexPath.row].name
        cell.detailTextLabel?.text = phoneBookData[indexPath.row].number
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let isSuccessDelete = provider.deletePhoneBookData(index: indexPath.row)
            refreshPhoneBookData()
            print("delete row \(indexPath.row) status : \(isSuccessDelete)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let navCon = mainStoryboard.instantiateViewController(withIdentifier: AddContactsTableViewController.AddContactsStoryboard.AddContactsTableViewNavigationControllerId) as? UINavigationController {
            let addContactsVC = navCon.topViewController as? AddContactsTableViewController
            addContactsVC?.phonebookDataIndex = indexPath.row
            addContactsVC?.editingType = .edit
            present(navCon, animated: true, completion: nil)
        }
    }
    
}

