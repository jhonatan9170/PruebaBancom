//
//  HomeVIewController.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import UIKit

protocol HomeDelegate:AnyObject{
    func getPosts(posts: [Post])
    func error(error: String)
    func getProjects(projects: [Project])
}

class HomeViewModel{

    var userDefaultsLayer = UserDefaultsLayer()

    var service: PostServiceProtocol
    
    weak var delegate: HomeDelegate?

    var coreDataMananger:CoreDataManagerProtocol = CoreDataManager.shared
    
    init(service: PostServiceProtocol = PostService()){
        self.service = service
    }
    
    func getPostsStored()->[Post]{
        let postsStored = coreDataMananger.fetchPosts()
        return postsStored.map { $0.toPost() }
    }

    func getPost(){
        guard let user = userDefaultsLayer.getUser() else {
            delegate?.error(error: "Usuario no reconocido")
            return
        }
        
        service.getPosts(id: user.id) { [weak self] posts in
            if let posts{
                var postsToView = posts
                postsToView.append(contentsOf: self?.getPostsStored() ?? [])
                self?.delegate?.getPosts(posts: postsToView)
            }else {
                self?.delegate?.error(error: "Error al traer tareas")
            }
        }
    }
    
    func getProjects(){
        DispatchQueue.global().asyncAfter(deadline: .now()+1.5) {
            let mockProjects = [Project(title: "New Assitant App", date: "Oct 12 ,2019", progress: 0.3, images: [UIImage(named: "icon_google"),UIImage(named: "icon_google"),UIImage(named: "icon_google")]),
                                Project(title: "Lecture ", date: "Sep 09, 2020", progress: 0.6, images: [UIImage(named: "icon_google"),UIImage(named: "icon_google")]),
                                Project(title: "Master Engeniering", date: "Aug 19, 2022", progress: 0.9, images: [UIImage(named: "icon_google"),UIImage(named: "icon_google"),UIImage(named: "icon_google")])
            ]
            self.delegate?.getProjects(projects: mockProjects)
        }
    }
}
