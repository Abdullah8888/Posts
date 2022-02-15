//
//  PostsViewModel.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import Foundation

protocol PostsViewModelDelegate: AnyObject {
    func didFetchPosts()
    func didFetchPostsFails(_ message: String)
}

class PostsViewModel: BaseViewModel {
    
    var postsDelegate: PostsViewModelDelegate?
    var posts: Posts = []
    
    func getPosts() {
        
        networkService.fetch(with: Config.baseURL() + "posts", method: .get, type: Posts.self) { success, response in
            
            if success {
                if let posts = response as? Posts {
                    self.posts = posts
                }
                self.postsDelegate?.didFetchPosts()
            }
            else {
                guard let error = response as? ErrorModel else {
                    self.postsDelegate?.didFetchPostsFails(.defaultError)
                    return
                }
                self.postsDelegate?.didFetchPostsFails(error.message ?? .defaultError)
            }
        }
    }
    
    
}
