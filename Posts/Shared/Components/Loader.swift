//
//  Loader.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 08/02/2022.
//

import UIKit

class Loader: UIView {
    
    static let shared = Loader()
    private let activity = UIActivityIndicatorView(style: .whiteLarge)

    func showLoader() {
        guard let window = UIApplication.shared.keyWindow else {return}
        window.addSubview(self)
        fillSuperview()
        window.bringSubviewToFront(self)
        addSubview(activity)
        activity.centerInSuperview()
        activity.startAnimating()
        backgroundColor = .gray
    }
    
    func hideLoader() {
        activity.stopAnimating()
        activity.hidesWhenStopped = true
        removeFromSuperview()
    }
}
