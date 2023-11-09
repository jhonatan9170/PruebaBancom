//
//  SceneDelegate.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 6/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var userDefaultsLayer = UserDefaultsLayer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        
        if shouldKeepLoggedIn() {
            let storyboard = UIStoryboard(name: "TasksStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewControllerId")
            let navigationController = UINavigationController(rootViewController: vc)
                
            window.rootViewController = navigationController
        } else {
            cleanUserDefaults()
            cleanCoreData()
            let vc = LoginViewController(nibName: String(describing: LoginViewController.self), bundle: nil)
            window.rootViewController = vc
        }
        
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func shouldKeepLoggedIn() -> Bool {
        let keepLoggedIn = userDefaultsLayer.getValue(forKey: Constants.keepLoginKey) as? Bool
        if keepLoggedIn == true {
            if let lastLoginDate = userDefaultsLayer.getValue(forKey: Constants.dateLoginKey) as? Date {
                return lastLoginDate.timeIntervalSinceNow > -15 * 60
            }
        }
        return false
    }
    
    private func cleanUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
            UserDefaults.standard.synchronize() // This is for legacy purposes and not needed in most cases
        }
    }
    
    private func cleanCoreData() {
        CoreDataManager.shared.deleteAllData()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

