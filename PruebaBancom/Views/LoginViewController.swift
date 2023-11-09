//
//  LoginViewController.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 7/11/23.
//

import UIKit
import MaterialComponents
import SimpleCheckbox

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passWordTextField: MDCOutlinedTextField!
    @IBOutlet weak var rememberCheckBox: Checkbox!
        
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        setCheckBox()
        viewModel.delegate = self
    }
    
    func setTextFields() {
        emailTextField.label.font = UIFont(name: "helvetica neue", size: 16.0)
        emailTextField.label.text = "Correo electrónico"
        emailTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .editing)
        emailTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .normal)
        
        passWordTextField.label.font = UIFont(name: "helvetica neue", size: 16.0)
        passWordTextField.label.text = "Contraseña"
        passWordTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .editing)
        passWordTextField.setOutlineColor(UIColor(white: 0.1, alpha: 0.5), for: .normal)
    }
    
    func setCheckBox(){
        rememberCheckBox.checkedBorderColor = .purple
        rememberCheckBox.uncheckedBorderColor = .purple
        rememberCheckBox.checkmarkColor = .purple
        rememberCheckBox.valueChanged = {[weak self] (isChecked) in
            self?.viewModel.keepLogin = isChecked
        }
    }
    
    @IBAction func showHidePasswordBtnTapped(_ sender: UIButton) {
        if passWordTextField.isSecureTextEntry {
            passWordTextField.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            passWordTextField.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @IBAction func ingresarBtnTapped(_ sender: UIButton) {
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passWordTextField.text ?? ""
        viewModel.login()
    }
    @IBAction func ingresarGoogleBtnTapped(_ sender: UIButton) {
        viewModel.service = MockGoogleService()
        viewModel.login()
    }
}

extension LoginViewController: LoginProtocol {
    func login(user: User) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "TasksStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewControllerId")
            let navigationController = UINavigationController(rootViewController: vc)
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }
    }
    
    func login(error: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
