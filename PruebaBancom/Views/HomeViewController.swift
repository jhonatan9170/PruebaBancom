//
//  HomeViewController.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 7/11/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var proyectCollectionView: UICollectionView!
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    var posts: [Post] = []
    var projects: [Project] = []
    var viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setViews()
        viewModel.getPost()
        viewModel.getProjects()
    }
    
    func setViews(){
        proyectCollectionView.register(UINib(nibName: "ProjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProjectCollectionViewCell")
        proyectCollectionView.backgroundColor = .clear
        taskListTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        taskListTableView.backgroundColor = .clear
        
        nameLabel.text = viewModel.getUsername()
    }
    

    func setDelegates(){
        proyectCollectionView.dataSource = self
        proyectCollectionView.delegate = self

        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        
        viewModel.delegate = self

    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateTaskViewControllerId") as? CreateTaskViewController {
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let post = posts[indexPath.row]
        cell.configure(task: post)
        return cell
    }


    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCollectionViewCell", for: indexPath) as! ProjectCollectionViewCell
        cell.backgroundColor = .clear
        let project = projects[indexPath.row]
        cell.configure(project: project)
        return cell
        
    }
}

extension HomeViewController: HomeDelegate {
    func getPosts(posts: [Post]) {
        self.posts = posts
        DispatchQueue.main.async {
            self.taskListTableView.reloadData()
        }
        
    }
    
    func error(error: String) {
        
    }
    
    func getProjects(projects: [Project]) {
        self.projects = projects
        DispatchQueue.main.async {
            self.proyectCollectionView.reloadData()
        }
    }
}

extension HomeViewController: CreateTaskDelegate{
    func didCreateNewPost() {
        viewModel.getPost()
    }
    
    
}
