//
//  PostsViewController.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import Foundation
import UIKit

class PostsViewController: BaseViewController<PostsView> {
    
    private let viewModel = PostsViewModel()
    private let group = DispatchGroup()
    private var toast = Toast.shared
    private var realm = RealmManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        viewModel.postsDelegate = self
        viewModel.usersDelegate = self
        fetchUserWithPost()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /// This fist checks if the required data is cached, if not
    /// Users and Post will be fetch from the server
    func fetchUserWithPost() {
        Loader.shared.showLoader()
        if realm.hasPosts {
            _view.data = realm.userWithPosts
            Loader.shared.hideLoader()
            return
        }
        group.enter()
        viewModel.fetchUsers()
        group.enter()
        viewModel.getPosts()
        
        group.notify(queue: .main) {
            self.setupRequiredData()
            Loader.shared.hideLoader()
        }
    }
    
    /// This set up required data that will be displayed and it is cached.
    func setupRequiredData() {
        var userWithPosts: [UserWithPost] = []
        _ = viewModel.posts.map { post in
            if let user = viewModel.users.first(where: {$0.id == post.userID}) {
                let data = UserWithPost()
                data.userId = user.id
                data.avatar = user.avatar?.thumbnail
                data.title = post.title
                data.body = post.body
                data.username = user.username
                userWithPosts.append(data)
            }
        }
        realm.userWithPosts = userWithPosts
        _view.data = realm.userWithPosts
    }
    
}

extension PostsViewController: PostsViewModelDelegate {
    
    func didFetchPostsFails(_ message: String) {
        toast.showToastWithTItle(message, type: .error)
        group.leave()
    }
    
    func didFetchPosts() {
        group.leave()
    }
    
}

extension PostsViewController: UsersDelegate {
    
    func didFetchUsers() {
        group.leave()
    }
    
    func didFetchUsersFails(_ message: String) {
        toast.showToastWithTItle(message, type: .error)
        group.leave()
    }

}
