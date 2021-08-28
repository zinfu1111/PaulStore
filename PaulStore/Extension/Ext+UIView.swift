//
//  Ext+UIView.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/28.
//

import UIKit
import Foundation


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
