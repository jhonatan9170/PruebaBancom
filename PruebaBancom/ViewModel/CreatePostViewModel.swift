//
//  createPostViewModel.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import CoreData
protocol CreatePostDelegate:AnyObject{
    func createPost(post: Post)
    func createPost(error: String)
}

class CreatePostViewModel{
    
    var title: String = ""
    var body: String = ""
    
    var service: PostServiceProtocol
    
    weak var delegate: CreatePostDelegate?
    
    var userDefaultsLayer = UserDefaultsLayer()
    var coreDataMananger:CoreDataManagerProtocol = CoreDataManager.shared
    init(service: PostServiceProtocol = PostService()){
        self.service = service
    }
    
    func createPost(){
        guard let user = userDefaultsLayer.getUser() else {
            delegate?.createPost(error: "Usuario no reconocido")
            return
        }
        let request = PostRequest(title: title, body: body, userId: user.id)
        service.createPost(request: request) { [weak self] post in
            if let post {
                self?.coreDataMananger.savePost(userId: post.userId, id: post.userId, title: post.title, body: post.body)
                self?.delegate?.createPost(post: post)
            }else {
                self?.delegate?.createPost(error: "No se pudo crear el post")
            }
        }
    }
}
