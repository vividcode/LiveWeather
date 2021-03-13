//
//  ViewController.swift
//  LiveWeather
//
//  Created by Nirav Bhatt on 11/3/20.
//

import Foundation
import UIKit

typealias AlertOkBlock = () -> Void
typealias AlertCancelBlock = () -> Void

extension UIViewController {
    static let messageLabelTag = 1000

    func showMessageLabel(msg: String, callBack: @escaping () -> Void = {}, completionBlockDelay: TimeInterval = 3.0) {
        if let l = self.view.viewWithTag(UIViewController.messageLabelTag) {
            l.removeFromSuperview()
        }

        let label = self.addLabel(msg: msg)
        label.tag = UIViewController.messageLabelTag
        DispatchQueue.main.asyncAfter(deadline: .now() + completionBlockDelay) {
            label.removeFromSuperview()
            callBack()
        }
    }

    private func addLabel(msg: String) -> UILabel {
        let bounds = self.view.bounds
        let w =  bounds.size.width*0.7
        let h: CGFloat =  80.0
        let yPos: CGFloat = bounds.size.height*0.45

        let label: UILabel = UILabel(frame: CGRect.init(x: (bounds.size.width - w)/2, y: yPos, width: w, height: h))
        label.backgroundColor = UIColor.errorMessage
        label.textColor = .white
        label.textAlignment = .center
        label.text = msg
        label.numberOfLines = 0
        label.applyShadow()
        label.cornerRadius = 8.0
        label.font = UIFont.systemFont(ofSize: UIOptions.messageFontHeight)

        self.view.addSubview(label)

        label.alpha = 0
        label.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        label.appearWithSpring()

        return label
    }

    func showAlert(msg: String, title: String = Bundle.getProductDisplayName(), okTitle: String?,
				   otherTitle: String = "", otherPressed: @escaping AlertOkBlock = {}, cancelTitle: String?,
				   okPressed: AlertOkBlock?, cancelPressed: AlertCancelBlock?, isOKDestructive: Bool = false) {
        let alert: UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if let okTitle = okTitle {
            let okAction =  UIAlertAction.init(title: okTitle,
											   style: isOKDestructive ? .destructive : .default) { (_) in
                okPressed?()
            }
            alert.addAction(okAction)
        }

        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel) { (_) in
                cancelPressed?()
            }
            alert.addAction(cancelAction)
        }

        if !otherTitle.isEmpty {
            let otherAction = UIAlertAction.init(title: otherTitle, style: .default) { (_) in
                otherPressed()
            }
            alert.addAction(otherAction)
		}
        self.present(alert, animated: true, completion: nil)
    }
}
