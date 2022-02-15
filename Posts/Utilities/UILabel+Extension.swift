//
//  UILabel+Extension.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 11/01/2022.
//

import UIKit

extension UILabel {
    
    func setLineHeight(spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func cross(){
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attr.length))
        attributedText = attr
    }
    
    func underline(){
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attr.length))
        attributedText = attr
    }

}
