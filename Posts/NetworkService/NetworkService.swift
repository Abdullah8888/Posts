//
//  NetworkService.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import Foundation
import Alamofire

struct ErrorModel: Codable, Error {
    let message: String?
}

protocol NetworkServiceProtocol: AnyObject {
    
    func fetch<T: Codable>(with url:String, method: HTTPMethod,
                                         type: T.Type, completionHandler
                                            completion: @escaping (Bool, Codable?) -> ())
    func fetchUserToken(with urlString: String, userName: String, password: String, completion: @escaping (Bool, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    func fetchUserToken(with urlString: String, userName: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        let headers: HTTPHeaders = [
            .authorization(username: userName, password: password),
            .accept("application/json"),
        ]
        request.headers = headers
        
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.value as? [AnyHashable : Any] {
                    if let accesToken = value["api_key"] as? String {
                        KeyChainManager.shared.accessToken = accesToken
                    }
                    completion(true, nil)
                }
            case let .failure(error):
                let error = ErrorModel(message: error.errorDescription)
                completion(false, error)
                
            }
        }
    }
    
    func fetch<T: Codable>(with urlString:String, method: HTTPMethod,
                                         type: T.Type, completionHandler
                                            completion: @escaping (Bool, Codable?) -> ())  {
        
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        if !KeyChainManager.shared.accessToken.isEmpty {
            request.setValue(KeyChainManager.shared.accessToken, forHTTPHeaderField: "x-access-token")
        }
      
        AF.request(request).responseJSON  { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    if let decodedResponse = try? JSONDecoder().decode(type.self, from: data) {
                        completion(true, decodedResponse)
                    }
                    else {
                        if let decodedResponse = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                            completion(false, decodedResponse)
                        }
                        else {
                            let error = ErrorModel(message: "Unable to parse JSON")
                            completion(false, error)
                        }
                    }
                }
            case let .failure(error):
                let error = ErrorModel(message: error.errorDescription)
                completion(false, error)
            }
        }
    }
    
}
