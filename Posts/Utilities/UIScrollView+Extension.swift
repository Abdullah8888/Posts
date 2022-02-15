//
//  UIScrollView+Extension.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import UIKit

public extension UIScrollView {
    func updateContentView(_ offset: CGFloat = 50) {
        contentSize.height = (subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height) + offset
    }
}
