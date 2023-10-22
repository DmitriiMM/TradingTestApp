//
//  UIViewController+Extensions.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 19.10.2023.
//

import UIKit

extension UIViewController {
    func observeKeyboardAppearing() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    private func onKeyboardAppear(notification: NSNotification) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        guard let gestureRecognizers = self.view.gestureRecognizers else {
            return
        }
        gestureRecognizers.forEach {
            $0.isEnabled = false
        }
        self.view.endEditing(true)
    }
}
