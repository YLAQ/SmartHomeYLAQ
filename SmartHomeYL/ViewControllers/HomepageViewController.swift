//
//  HomepageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {

    func turn() -> String {
        if (UserDefaults.standard.object(forKey: "userName") != nil) {
            let username = UserDefaults.standard.object(forKey: "userName") as! String
            return username
        } else {
            let username = ""
            return username
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        let username = turn()
        print(username)
        if username == "" {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loginpage")
            //推出新的Controller
            // 在这里加一个这个样式的循环

            self.tabBarController!.present(vc, animated: true, completion: nil)
            //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            //                print("时间2：", Date())
            //            }
        } else {
            print(username)
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
}

