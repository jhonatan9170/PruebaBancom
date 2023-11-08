//
//  UserDefaultLayer.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func value(forKey defaultName: String) -> Any?
}

extension UserDefaults: UserDefaultsProtocol {}

class UserDefaultsLayer {
    private let defaults: UserDefaultsProtocol
    
    init(defaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    func save(value: Any?, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func saveUser(value: User){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            defaults.set(encoded, forKey: Constants.userKey)
        }
    }
    
    func getUser()->User?{
        if let savedUserData = defaults.value(forKey: Constants.userKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUserData) {
                return loadedUser
            }
        }
        return nil
    }
    
    func getValue(forKey key: String) -> Any? {
        return defaults.value(forKey: key)
    }
}
