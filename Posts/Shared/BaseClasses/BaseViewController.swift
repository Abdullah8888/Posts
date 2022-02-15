//
//  BaseViewController.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import UIKit

class BaseViewController<SubView: UIView>: UIViewController {
    let _view: SubView
    
    init(view: SubView = SubView()) {
        self._view = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
        view.clipsToBounds = true
    }
}
