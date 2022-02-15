//
//  UIView+Extension.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 11/01/2022.
//

import UIKit

extension UIView {
    
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func applyShadow(radius:CGFloat = 5){
        layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = radius
        layer.shadowOffset = .init(width: 0, height: radius)
    }
    
    func roundAllCorners(radius: CGFloat) {
        layer.borderWidth = 0.2
        layer.cornerRadius = radius
        layer.borderColor = UIColor(hexString: "#767272").cgColor
    }
    
    func roundTopCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func roundBottomCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func applyShadowWith(radius: CGFloat) {
        var shadowLayer: CAShapeLayer!
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor
            shadowLayer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .init(width: 0, height: 10)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 5
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

