//
//  LabelWithPadding.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import UIKit

class Label: UILabel {

    private var insets = UIEdgeInsets(allEdges: 0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + insets.left + insets.right, height: originalSize.height + insets.top + insets.bottom)
    }
    
    init(text: String, font: UIFont, numberOfLines: Int = 0, color: UIColor = .black, alignment: NSTextAlignment = .left, underlined: Bool = false, padding: UIEdgeInsets = .init(allEdges: 0)) {
        super.init(frame: .zero)
        self.font = font
        self.text = text
        self.textColor = color
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.insets = padding
        self.lineBreakMode = .byWordWrapping
        //self.adjustsFontSizeToFitWidth = true
        if underlined {
            underline()
        }
    }
    
    init(attributedText: NSAttributedString, numberOfLines: Int = 0, alignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.attributedText = attributedText
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
