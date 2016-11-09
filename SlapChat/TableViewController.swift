//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TableViewController: UITableViewController {

    let store = DataStore.sharedInstance
    
   // var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
        
        if store.messages.isEmpty {
            store.generateTestData()
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.fetchData()
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let message = store.messages[indexPath.row]
        cell.textLabel?.text = message.content
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
       return  1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return store.messages.count
    }

}
