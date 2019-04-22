//
//  AppStoreViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/19.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class AppStoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //弹出消息框
        let alertController = UIAlertController(title: "觉得好用的话，给我个评价吧！",
                                                message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "暂不评价", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default,
                                     handler: {
                                        action in
                                        self.gotoAppStore()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //跳转到应用的AppStore页页面
    func gotoAppStore() {
        //提交 app 时候自动生成的AppID
        let urlString = "itms-apps://itunes.apple.com/app/id444934666"
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
