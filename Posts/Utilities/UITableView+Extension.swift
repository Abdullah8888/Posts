//
//  UITableView+Extension.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 09/02/2022.
//

import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        messageLabel.sizeToFit()
        emptyView.addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        separatorStyle = .none
        self.backgroundView = emptyView
    }
    
    func restore() {
        separatorStyle = .singleLine
        self.backgroundView = nil
    }
}
