//
//  Warning.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/15.
//  Copyright © 2019 yu li. All rights reserved.
//

import Foundation
import UIKit

class Warning {
//
//    private var token : NotificationToken? = nil //监听
    
    
//    let vc = UIViewController.currentViewController()
    let vc = HomepageViewController()
    //提示
    func showMsgbox(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        alert.addAction(btnOK)
        vc.present(alert, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
