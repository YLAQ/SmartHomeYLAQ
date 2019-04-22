//
//  MypageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class MypageViewController: UIViewController {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var hp: UIImageView!
    @IBOutlet weak var modifyBtn: UIButton!
    
    let name = UserDefaults.standard.object(forKey: "userName") as! String
    let user = try! Realm().objects(Users.self)
    //判断注册表是否为空
    
    override func loadView() {
        super.loadView()
        //用户名、电话
        username.text = name
        for item in user {
            if name == item.name {
                tel.text = item.phone
                print(item.phone)
            }
        }
        
        //用户头像
        hp.image = UIImage(named: "hp")
        hp.layer.cornerRadius = 33
        
        
    }
    //登录点击事件
    @objc func handleLogin(sender:UIButton){
        
    }
    
    
}
