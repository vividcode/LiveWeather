//
//  View.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/3/20.
//

import Foundation
import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            self.clipsToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }

    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func applyShadow(radius: CGFloat = 5.0, shadowColor: UIColor = .black) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor

        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.backgroundColor =  self.backgroundColor?.cgColor
    }

    func appearWithSpring(duration: TimeInterval = 0.8, completion: @escaping () -> Void = {}) {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75,
					   initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transform = .identity
            self.alpha = 1
        }, completion: { _ in
            DispatchQueue.main.async {
                completion()
            }
        })
    }

    func applySubViewChanges<T: UIView>(forSubviewType: T.Type, closure: (T) -> Void) {
        let subViewArray = (self.isKind(of: UIStackView.classForCoder())) ?
			(self as! UIStackView).arrangedSubviews : self.subviews

        for subView in subViewArray {
            if subView.isKind(of: T.classForCoder()) {
                closure(subView as! T)
            } else if (subView.isMember(of: UIView.classForCoder()))
						|| (subView.isMember(of: UIStackView.classForCoder())) {
                subView.applySubViewChanges(forSubviewType: forSubviewType, closure: closure)
            }
        }
    }
}
