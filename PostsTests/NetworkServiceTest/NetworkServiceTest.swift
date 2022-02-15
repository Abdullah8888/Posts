//
//  NetworkServiceTest.swift
//  PostsTests
//
//  Created by Abdullah on 15/02/2022.
//

import XCTest
import Alamofire
@testable import Posts

class NetworkServiceTest: XCTestCase {
    
    func testFetchThatPass(){
        let sut = makeSut(fetchStatus: true)
        sut.fetch(with: "", method: .get, type: Posts.self, completionHandler: { success, response in
            XCTAssertTrue(success)
        })
    }
    
    func testFetchThatFails() {
        let sut = makeSut(fetchStatus: false)
        sut.fetch(with: "", method: .get, type: Posts.self, completionHandler: { success, response in
            XCTAssertFalse(success)
        })
    }
    
    func testFetchUserTokenWithOutUserCredentialsThatPass() {
        let sut = makeSut(userTokenStatus: true)
        sut.fetchUserToken(with: "", userName: "", password: "", completion: { success, error in
            XCTAssertTrue(success)
        })
    }
    
    func testFetchUserTokenWithOutUserCredentialsThatFails() {
        let sut = makeSut(userTokenStatus: false)
        sut.fetchUserToken(with: "", userName: "", password: "", completion: { success, error in
            XCTAssertFalse(success)
        })
    }
    
    func testFetchUserTokenWithUserCredentialsThatPass() {
        let sut = makeSut(userTokenStatus: true)
        sut.fetchUserToken(with: "", userName: "testMan", password: "password1234", completion: { success, error in
            XCTAssertTrue(success)
        })
    }
    
    func testFetchUserTokenWithUserCredentialsThatFails() {
        let sut = makeSut(userTokenStatus: false)
        sut.userTokenStatus = false
        sut.fetchUserToken(with: "", userName: "testMan", password: "password1234", completion: { success, error in
            XCTAssertFalse(success)
        })
    }
    
    func makeSut(fetchStatus: Bool) -> MockNetworkService {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.fetchStatus = fetchStatus
        return mockNetworkService
    }
    
    func makeSut(userTokenStatus: Bool) -> MockNetworkService {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.userTokenStatus = userTokenStatus
        return mockNetworkService
    }
    
}

class MockNetworkService: NetworkServiceProtocol {
    var userTokenStatus: Bool = true
    var fetchStatus: Bool = true
    var posts = [Post(userID: 1, id: 1, title: "Swift", body: "A programing langauge")]
    var users = [User(id: 1, avatar: Avatar(large: "", medium: "", thumbnail: ""), username: "Ben")]
    var errorFromServer: ErrorModel?
    
    func fetch<T>(with url: String, method: HTTPMethod, type: T.Type, completionHandler completion: @escaping (Bool, Codable?) -> ()) {
    
        switch type {
        case is Posts.Type:
            completion(fetchStatus, fetchStatus ? posts : errorFromServer)
        case is Users.Type:
            completion(fetchStatus, fetchStatus ? users : errorFromServer)
        default:
            completion(fetchStatus, nil)
        }
    }
    
    func fetchUserToken(with urlString: String, userName: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        
        if userTokenStatus {
            MockKeyChainManager.shared.accessToken = .testAccessToken
        }
        completion(userTokenStatus, userTokenStatus ? errorFromServer : nil)
    }

}

