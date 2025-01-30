//
//  CoreDataManager.swift
//  SwiftUIDependencyInjection
//
//  Created by Siran Li on 7/28/24.
//

import Foundation
import CoreData

// MARK: - User Model
struct User: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
}

protocol UserStorage {
    func saveUsers(_ users: [User])
    func loadUsers() -> [User]
    func deleteUsers()
}

class CoreDataManager: UserStorage {
    static let shared = CoreDataManager()

    private init() {}

    var context: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }

    func saveUsers(_ users: [User]) {
        let context = self.context

        // Remove all existing users
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete existing users: \(error)")
        }

        // Add new users
        for user in users {
            let userEntity = UserEntity(context: context)
            userEntity.id = Int64(user.id)
            userEntity.name = user.name
            userEntity.username = user.username
            userEntity.email = user.email
            userEntity.phone = user.phone
        }

        do {
            try context.save()
        } catch {
            print("Failed to save users to Core Data: \(error)")
        }
    }

    func loadUsers() -> [User] {
        let context = self.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let userEntities = try context.fetch(fetchRequest)
            return userEntities.map { User(id: Int($0.id), name: $0.name!, username: $0.username!, email: $0.email!, phone: $0.phone!) }
        } catch {
            print("Failed to fetch users from Core Data: \(error)")
            return []
        }
    }

    func deleteUsers() {
        let context = self.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete users from Core Data: \(error)")
        }
    }
}

