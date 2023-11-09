//
//  CreateTaskViewController.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import UIKit
import MaterialComponents

protocol CreateTaskDelegate:AnyObject{
    func didCreateNewPost()
}

class CreateTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: MDCOutlinedTextField!
    @IBOutlet weak var bodyTextField: MDCOutlinedTextField!
    
    
    weak var delegate: CreateTaskDelegate?
    
    var viewModel = CreatePostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        self.title = "Crear"
        viewModel.delegate = self
    }

    func setTextFields() {
        titleTextField.label.font = UIFont(name: "helvetica neue", size: 16.0)
        titleTextField.label.text = "Titulo"
        titleTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .editing)
        titleTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .normal)
        
        bodyTextField.label.font = UIFont(name: "helvetica neue", size: 16.0)
        bodyTextField.label.text = "Descripcion"
        bodyTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .editing)
        bodyTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .normal)
    }
    
    @IBAction func creatButtonTapped(_ sender: UIButton) {
        viewModel.title = titleTextField.text ?? ""
        viewModel.body = bodyTextField.text ?? ""
        viewModel.createPost()
    }
}

extension CreateTaskViewController: CreatePostDelegate {
    func createPost(post: Post) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.delegate?.didCreateNewPost()
        }

    }
    
    func createPost(error: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
