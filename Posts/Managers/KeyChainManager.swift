//
//  KeyChainManager.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 13/01/2022.
//

import Foundation
import KeychainSwift

protocol KeyChainManagerProtocol: AnyObject {
    var accessToken: String { get set }
}

class KeyChainManager: KeyChainManagerProtocol {
    static let shared = KeyChainManager()
    private let keychain = KeychainSwift()
    var accessToken: String {
        set {
            keychain.set(newValue, forKey: .accessToken)
        }
        get {
            keychain.get(.accessToken) ?? ""
        }
    }
}
