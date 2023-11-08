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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        setCheckBox()
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
        rememberCheckBox.valueChanged = { (isChecked) in
            print("checkbox is checked: \(isChecked)")
        }
    }
    
    @IBAction func showHidePasswordBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func ingresarBtnTapped(_ sender: UIButton) {
        
    }
    @IBAction func ingresarGoogleBtnTapped(_ sender: UIButton) {
        
    }
}
