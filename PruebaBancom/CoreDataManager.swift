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
}

