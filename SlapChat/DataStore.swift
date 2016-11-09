//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    var messages = [Message]()
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "slapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
           
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData() {
        let managedContext = self.context // aka persistentContainer.viewContext
        let request = Message.request // aka NSFetchRequest<Message>(entityName: "Message")
        // let fetchTwo: NSFetchRequest<Message> = Message.fetchRequest()
        guard let messagesRetrived = try? managedContext.fetch(request) else { return }
        self.messages = messagesRetrived
        
        let sortedMessages = messagesRetrived.sorted { (messageA, messageB) -> Bool in
            if let dateA = messageA.createdAt, let dateB = messageB.createdAt {

                let dateAA = dateA as! Date
                let dateBB = dateB as! Date
                
                return dateAA > dateBB

            }
            return false
        }
        
        self.messages = sortedMessages
    }
    
    func generateTestData() {
        
        let managedContext = self.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext) else { return }
        
        
        let message = NSManagedObject(entity: entity, insertInto: managedContext) as! Message
        message.content = "Wassup?"
        message.createdAt = NSDate()
        
        let message2 = Message(context: managedContext)
        message2.content = "How are you?"
        message2.createdAt = NSDate()
        
        self.saveContext()
        
        
        fetchData()
        
    }
    
    
    
}
