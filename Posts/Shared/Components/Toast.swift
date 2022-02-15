//
//  Toast.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 12/01/2022.
//

import UIKit

public enum ToastType {
    case success,error
}

public class Toast: UIView {
    
    let titleLabel = Label(text: "", font: .helveticaNeueMedium(), numberOfLines: 0, color: .white, padding: .leftOnly(20))
    var type: ToastType = .success{
        didSet{
            switch (type) {
            case .error:
                backgroundColor = .red
                break
            case .success:
                backgroundColor = .deepGreep
                break
            }
        }
    }
    static var shared = Toast()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        //applyShadow()
    }

    func showToastWithTItle(_ title: String, type: ToastType) {
        self.type = type
        self.titleLabel.text = title
        guard let window = UIApplication.shared.keyWindow else {return}
        window.addSubview(self)
        window.bringSubviewToFront(self)
        anchor(top: window.topAnchor, leading: window.leadingAnchor, bottom: nil, trailing: window.trailingAnchor, margin: .init(top: Constant.notchHeight() + 10, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: Constant.notchHeight() + 45))
        
        transform = .init(translationX: 0, y: -200)
        roundAllCorners(radius: 5)
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: nil)
        hideToast()
    }
    
    func hideToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.beginHideToast()
        }
    }
    
    private func beginHideToast(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.transform = .init(translationX: 0, y: -200)
        }, completion: nil)
    }
    
}

