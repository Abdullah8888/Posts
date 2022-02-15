//
//  PostsViewModelTest.swift
//  PostsTests
//
//  Created by Abdullah on 15/02/2022.
//

import XCTest
@testable import Posts

class PostsViewModelTest: XCTestCase {

    func testFetchPostsWithTrueStatus() {
        let sut = makeSut()
        sut.getPosts()
        XCTAssertTrue(sut.posts.count > 0)
    }
    
    func testPostsWithEmptyPosts() {
        let mockNetworkService = makeMockNetworkService()
        let sut = makeSut(mockNetworkService)
        sut.getPosts()
        XCTAssertTrue(sut.posts.isEmpty)
    }
    
    func testPostsWithFailStatusWithCastedError() {
        let mockNetworkService = makeMockNetworkService(fetchStatus: false)
        let sut = makeSut(mockNetworkService)
        sut.getPosts()
    }

    func testPostsWithFailStatusWithUnCastedError() {
        let mockNetworkService = makeMockNetworkService(fetchStatus: false, posts: nil, error: nil)
        let sut = makeSut(mockNetworkService)
        sut.getPosts()
    }
    
    func makeSut(_ mockNetworkService: MockNetworkService = MockNetworkService()) -> PostsViewModel {
        let viewModel = PostsViewModel()
        viewModel.networkService = mockNetworkService
        viewModel.postsDelegate = self
        return viewModel
    }
    
    func makeMockNetworkService(fetchStatus: Bool = true, posts: Posts? = nil, error: ErrorModel? = ErrorModel(message: .castedErrorFromServer)) -> MockNetworkService {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.fetchStatus = fetchStatus
        mockNetworkService.posts = posts ?? []
        mockNetworkService.errorFromServer = error
        return mockNetworkService
    }
    
}

extension PostsViewModelTest: PostsViewModelDelegate {
    func didFetchPosts() {
        XCTAssertTrue(true)
    }
    
    func didFetchPostsFails(_ message: String) {
        XCTAssertTrue([.castedErrorFromServer, .defaultError].contains{ $0 == message})
    }
}
