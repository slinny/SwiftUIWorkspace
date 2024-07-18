//
//  CoreData.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/15/24.
//

import Foundation

/*
 Core Data is a powerful framework provided by Apple for managing the model layer objects in an application. It provides a way to manage the object graph and persist data to a persistent store. Here are some key points and best practices to keep in mind when working with Core Data:

 Core Data Components
 NSManagedObjectContext: A context represents a single object space or scratchpad. Changes to managed objects are made through the context.
 NSManagedObjectModel: This model is a representation of the schema or structure of the data.
 NSPersistentStoreCoordinator: Coordinates multiple persistent object stores and manages access to the data.
 NSPersistentContainer: A convenience class that encapsulates the Core Data stack and provides a standard way to manage the model, context, and store.
 Basic Steps for Using Core Data
 Define the Data Model:

 Use Xcode’s model editor to create a .xcdatamodeld file.
 Define entities, attributes, and relationships.
 Set Up the Core Data Stack:

 Use NSPersistentContainer to set up the stack easily.
 swift
 Copy code
 import CoreData

 class PersistentContainer {
     static let shared = PersistentContainer()

     let persistentContainer: NSPersistentContainer

     private init() {
         persistentContainer = NSPersistentContainer(name: "ModelName")
         persistentContainer.loadPersistentStores { (storeDescription, error) in
             if let error = error {
                 fatalError("Unresolved error \(error)")
             }
         }
     }

     var context: NSManagedObjectContext {
         return persistentContainer.viewContext
     }
 }
 Perform CRUD Operations:

 Create:
 swift
 Copy code
 let context = PersistentContainer.shared.context
 let entity = NSEntityDescription.entity(forEntityName: "EntityName", in: context)!
 let object = NSManagedObject(entity: entity, insertInto: context)
 object.setValue("Value", forKey: "AttributeName")
 try? context.save()
 Read:
 swift
 Copy code
 let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EntityName")
 let objects = try? context.fetch(fetchRequest)
 Update:
 swift
 Copy code
 object.setValue("NewValue", forKey: "AttributeName")
 try? context.save()
 Delete:
 swift
 Copy code
 context.delete(object)
 try? context.save()
 Best Practices
 Use Background Contexts for Intensive Operations:

 Perform data-intensive operations like importing large datasets on a background context to avoid blocking the main thread.
 swift
 Copy code
 persistentContainer.performBackgroundTask { (context) in
     // Perform background operations
     try? context.save()
 }
 Batch Operations:

 Use NSBatchInsertRequest and NSBatchUpdateRequest for batch operations to improve performance.
 swift
 Copy code
 let batchInsert = NSBatchInsertRequest(entityName: "EntityName", objects: arrayOfDictionaries)
 try? context.execute(batchInsert)
 Faulting and Unloading:

 Core Data uses faulting to manage memory. Be mindful of how you access properties of managed objects to avoid unnecessary faults.
 Optimizing Fetch Requests:

 Use predicates and sort descriptors to limit the amount of data fetched.
 swift
 Copy code
 fetchRequest.predicate = NSPredicate(format: "attribute == %@", "value")
 fetchRequest.sortDescriptors = [NSSortDescriptor(key: "attribute", ascending: true)]
 Migration:

 Plan for schema changes by using lightweight migration or manual migration strategies.
 Example: Saving and Fetching Data
 Here's a more detailed example illustrating how to save and fetch data:

 swift
 Copy code
 import CoreData
 import UIKit

 class CoreDataHelper {
     static let shared = CoreDataHelper()
     let context = PersistentContainer.shared.context

     // Save data
     func saveItem(name: String) {
         let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)!
         let item = NSManagedObject(entity: entity, insertInto: context)
         item.setValue(name, forKey: "name")
         do {
             try context.save()
         } catch {
             print("Failed to save item: \(error)")
         }
     }

     // Fetch data
     func fetchItems() -> [NSManagedObject] {
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
         do {
             return try context.fetch(fetchRequest)
         } catch {
             print("Failed to fetch items: \(error)")
             return []
         }
     }
 }

 // Usage
 let coreDataHelper = CoreDataHelper.shared
 coreDataHelper.saveItem(name: "Sample Item")
 let items = coreDataHelper.fetchItems()
 print(items)
 Core Data is a comprehensive framework that offers various features for managing data in your app. Understanding its components and best practices can help you use it effectively and efficiently.
 */
