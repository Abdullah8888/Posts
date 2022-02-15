//
//  BaseView.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import UIKit

class BaseView: UIView {

    func setup(){
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
