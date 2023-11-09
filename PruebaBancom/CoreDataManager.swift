//
//  File.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//


import CoreData
protocol CoreDataManagerProtocol {
    func fetchPosts() -> [PostsData]
    func savePost(userId: Int, id: Int, title: String, body: String)
}
class CoreDataManager: CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model") // Replace with your data model name
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func savePost(userId: Int, id: Int, title: String, body: String) {
        let context = persistentContainer.viewContext
        let post = PostsData(context: context)
        post.userId = Int64(userId)
        post.id = Int64(id)
        post.title = title
        post.body = body
        
        do {
            try context.save()
        } catch {
            print("Failed to save post: \(error)")
        }
    }
    
    func fetchPosts() -> [PostsData] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PostsData> = PostsData.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch posts: \(error)")
            return []
        }
    }
    func deleteAllData() {
        let context = persistentContainer.viewContext
        // Replace 'EntityName' with your actual entity names
        let entities = persistentContainer.managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearDeepObjectEntity)
    }

    private func clearDeepObjectEntity(entity: String) {
        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            // Handle error here
            print("Could not delete all data in \(entity): \(error), \(error.userInfo)")
        }
    }
}

