//
//  BaseViewModelTest.swift
//  PostsTests
//
//  Created by Abdullah on 15/02/2022.
//

import XCTest
@testable import Posts

class BaseViewModelTest: XCTestCase {

    func testFetchUsersWithTrueStatus() {
        let sut = makeSut()
        sut.fetchUsers()
        XCTAssertTrue(sut.users.count > 0)
    }
    
    func testFetchUsersWithFailStatusWithCastedError() {
        let mockNetworkService = makeMockNetworkService(fetchStatus: false)
        let sut = makeSut(mockNetworkService)
        sut.fetchUsers()
    }
    
    func testFetchUsersWithFailStatusWithUnCastedError() {
        let mockNetworkService = makeMockNetworkService(fetchStatus: false, error: nil)
        let sut = makeSut(mockNetworkService)
        sut.fetchUsers()
    }

    func testFetchUserTokenThatPass() {
        let sut = makeSut()
        sut.fectchUserToken()
        XCTAssertEqual(MockKeyChainManager.shared.accessToken, .testAccessToken)
    }

    func testFetchUserTokenThatFailsWithCastedError() {
        let mockNetworkService = makeMockNetworkService(userTokenStatus: false)
        let sut = makeSut(mockNetworkService)
        sut.fectchUserToken()
    }
    
    func testFetchUserTokenThatFailsWithUNCastedError() {
        let mockNetworkService = makeMockNetworkService(userTokenStatus: false, error: nil)
        let sut = makeSut(mockNetworkService)
        sut.fectchUserToken()
    }
    
    func makeSut(_ mockNetworkService: MockNetworkService = MockNetworkService()) -> BaseViewModel {
        let viewModel = BaseViewModel()
        viewModel.networkService = mockNetworkService
        viewModel.usersDelegate = self
        viewModel.accessTokenDelegate = self
        return viewModel
    }
    
    func makeMockNetworkService(fetchStatus: Bool = true, users: Users? = nil, error: ErrorModel? = ErrorModel(message: .castedErrorFromServer)) -> MockNetworkService {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.fetchStatus = fetchStatus
        mockNetworkService.users = users ?? []
        mockNetworkService.errorFromServer = error
        return mockNetworkService
    }
    
    func makeMockNetworkService(userTokenStatus: Bool = true, error: ErrorModel? = ErrorModel(message: .castedErrorFromServer)) -> MockNetworkService {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.userTokenStatus = userTokenStatus
        mockNetworkService.errorFromServer = error
        return mockNetworkService
    }

}

extension BaseViewModelTest: UsersDelegate {
    func didFetchUsers() {
        XCTAssertTrue(true)
    }
    
    func didFetchUsersFails(_ message: String) {
        XCTAssertTrue([.castedErrorFromServer, .defaultError].contains{ $0 == message})
    }
}

extension BaseViewModelTest: AccessTokenDelegate {
    func didFectchUserToken() {
        XCTAssertTrue(true)
    }
    
    func didFectchUserTokenFails(_ message: String) {
        XCTAssertTrue([.castedErrorFromServer, .defaultError].contains{ $0 == message})
    }
}

class MockKeyChainManager: KeyChainManagerProtocol {
    static let shared: MockKeyChainManager = MockKeyChainManager()
    var accessToken: String = ""
}

