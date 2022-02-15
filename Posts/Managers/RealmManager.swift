//
//  RealmManager.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 08/02/2022.
//

import RealmSwift

protocol RealmManagerProtocol: AnyObject {
    static var shared: RealmManagerProtocol { get }
    var userWithPosts: [UserWithPost] { get set }
    var hasPosts: Bool { get }
    func clear()
}

class RealmManager: RealmManagerProtocol {
    
    static var shared: RealmManagerProtocol = RealmManager()
    let realm = try! Realm()
    
    var userWithPosts: [UserWithPost] {
        set {
            let obj = realm.objects(UserWithPost.self).array
            try! realm.write({
                realm.delete(obj)
                realm.add(newValue)
            })
        }
        get {
            realm.objects(UserWithPost.self).array
        }
    }
    
    var hasPosts: Bool { !userWithPosts.isEmpty }
    
    func clear() {
        let obj = realm.objects(UserWithPost.self).array
        realm.delete(obj)
    }
}

extension Results {
    var array: [Element] { map{$0} }
}
