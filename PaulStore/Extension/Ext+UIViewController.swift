//
//  Ext+UIViewController.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/29.
//

import UIKit
import Foundation

extension UIViewController {
    
    func showAlert(title:String,msg:String? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let action = UIAlertAction(title: "我知道了！", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
