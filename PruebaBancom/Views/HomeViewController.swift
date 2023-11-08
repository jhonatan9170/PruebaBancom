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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        let request = PostRequest(title: "fdf", body: "sfaf", userId: 2)
        //APIClient.shared.request(url: Constants.createPostsURL, method: .post, parameters: request.dictionary) { (result: Result<Post, Error>) in }
        //let url = Constants.getUsersURL + "/1/posts"
        //APIClient.shared.request(url: url, method: .get) { (result: Result<PostResponse, Error>) in }
        //APIClient.shared.request(url: Constants.getUsersURL, method: .get) { (result: Result<UserResponse, Error>) in }
    }
    
    
    

    func setDelegates(){
        proyectCollectionView.dataSource = self
        proyectCollectionView.delegate = self
        proyectCollectionView.register(UINib(nibName: "ProjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProjectCollectionViewCell")
        proyectCollectionView.backgroundColor = .clear
        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        taskListTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        taskListTableView.reloadData()
        taskListTableView.backgroundColor = .clear
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }


    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCollectionViewCell", for: indexPath) as! ProjectCollectionViewCell
        cell.backgroundColor = .clear
        return cell
        
    }
}
