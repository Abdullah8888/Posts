//
//  BaseViewModel.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 14/01/2022.
//

import Foundation

protocol AccessTokenDelegate: AnyObject {
    func didFectchUserToken()
    func didFectchUserTokenFails(_ message: String)
}

protocol UsersDelegate: AnyObject {
    func didFetchUsers()
    func didFetchUsersFails(_ message: String)
}

class BaseViewModel {
    
    var usersDelegate: UsersDelegate?
    var accessTokenDelegate: AccessTokenDelegate?
    var networkService: NetworkServiceProtocol = NetworkService.shared
    var users: [User] = []
    
    func fectchUserToken(userName: String = "", password: String = "") {
        networkService.fetchUserToken(with: Config.baseURL() + "login", userName: userName, password: password) {
            success, error in
            if success {
                self.accessTokenDelegate?.didFectchUserToken()
            }
            else {
                guard let err = error as? ErrorModel  else {
                    self.accessTokenDelegate?.didFectchUserTokenFails(.defaultError)
                    return
                }
                self.accessTokenDelegate?.didFectchUserTokenFails(err.message ?? .defaultError)
            }
        }
    }
    
    func fetchUsers() {
        networkService.fetch(with: Config.baseURL() + "users", method: .get, type: Users.self) { success, response in
            if success {
                if let users = response as? Users {
                    self.users = users
                    self.usersDelegate?.didFetchUsers()
                }
            }
            else {
                guard let error = response as? ErrorModel else {
                    self.usersDelegate?.didFetchUsersFails(.defaultError)
                    return
                }
                self.usersDelegate?.didFetchUsersFails(error.message ?? .defaultError)
            }
            
        }
    }
}
