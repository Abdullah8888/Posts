//
//  ScrollableView.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import UIKit

class ScrollableView: BaseView {
    
    public let scrollView = UIScrollView()
    
    override func setup() {
        super.setup()
        addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.showsVerticalScrollIndicator = false
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        scrollView.updateContentView()
    }
}
