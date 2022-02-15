//
//  AppDelegate.swift
//  Posts
//
//  Created by Abdullah on 15/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: PostsViewController(view: PostsView()))
        window?.makeKeyAndVisible()
        fectchUserToken()
        return true
    }
    
   
    func fectchUserToken(userName: String = "", password: String = "") {
        if !KeyChainManager.shared.accessToken.isEmpty {
            return
        }
        let semephore = DispatchSemaphore(value: 0)
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        dispatchQueue.async {
            NetworkService.shared.fetchUserToken(with: Config.baseURL() + "login", userName: userName, password: password) {
                success, error in
                semephore.signal()
                if !success {
                    let err = error as! ErrorModel
                    Toast.shared.showToastWithTItle(err.message ?? .defaultError, type: .error)
                }
                semephore.wait()
            }
        }
    }

}

