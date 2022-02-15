//
//  Config.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 13/01/2022.
//

import Foundation

class Config {
    public static func baseURL () -> String {
        let baseUrl = Bundle.main.infoDictionary?[.appEnvironment] as! String == .staging ?
                                "https://engineering.league.dev/challenge/api/" : ""
        return baseUrl
    }
}
