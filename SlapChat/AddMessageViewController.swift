//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Joyce Matos on 11/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {

    let store = DataStore.sharedInstance
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func saveButton(_ sender: AnyObject) {
        
        let managedContext = store.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext) else { return }
        
        let customMessage = NSManagedObject(entity: entity, insertInto: managedContext) as! Message
        customMessage.content = "\(messageTextField.text!)"
        customMessage.createdAt = NSDate()
        
        store.saveContext()
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
