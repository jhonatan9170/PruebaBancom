//
//  LoginViewModel.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation

protocol LoginProtocol:AnyObject{
    func login(user: User)
    func login(error: String)
}

class LoginViewModel {
    var email = ""
    var password = ""
    var keepLogin = false
    weak var delegate: LoginProtocol?
    var service: UserServiceProtocol
    var userDefaultsLayer = UserDefaultsLayer()

    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    func login(){
        
        guard validateEmail() else  {
            delegate?.login(error: "Correo inválido")
            return
        }
        
        guard password.count > 7 else  {
            delegate?.login(error: "Contraseña debe tener minimo 8 caracteres")
            return
        }
        
        service.login(email: email, password: password) { [weak self] user in
            if let user {
                self?.saveData(user: user)
                self?.delegate?.login(user: user)
            }else {
                self?.delegate?.login(error: "Credenciales incorrectas")
            }
        }
    }
    
    func validateEmail() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    func saveData(user: User){
        let currentDate = Date()
        userDefaultsLayer.saveUser(value: user)
        userDefaultsLayer.save(value: keepLogin, forKey: Constants.keepLoginKey)
        userDefaultsLayer.save(value: currentDate, forKey: Constants.dateLoginKey)
    }
    
}

class MockGoogleService: UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping (User?) -> Void) {
        DispatchQueue.global().async {
            completion(User(id: 1, name: "Jhonatan Chavez", username: "jhonatan9170", email: "jhonatan9170@gmail.com", address: nil, phone: nil, website: nil, company: nil))
        }
    }
}
