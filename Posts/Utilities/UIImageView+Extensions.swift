//
//  UIImageView+Extensions.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 08/02/2022.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func showImage(imgUrl: String?) {
        let url = URL(string: imgUrl ?? "")
        sd_setImage(with: url, placeholderImage: nil, completed: nil)
    }
}
