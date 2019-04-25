//
//  userNameChangeViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/24.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class userNameChangeViewController: UIViewController {
    
    @IBOutlet weak var txt: UITextField!
    
    //判断username是否存在，存在即返回值，不存在即设为空
    func usernameexit() -> String {
        if (UserDefaults.standard.object(forKey: "userName") != nil) {
            let username = UserDefaults.standard.object(forKey: "userName") as! String
            return username
        } else {
            let username = ""
            return username
        }
    }
    
    func showMsgbox(_message: String, _title: String = "哎呀"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func submit(_ sender: UIButton) {
        if txt.text == ""{
            showMsgbox(_message: "用户名不能为空噢")
            return
        } else if txt.text!.count > 10 ,txt.text!.count < 5{
            showMsgbox(_message: "用户名要在5-10个字符之间噢")
        } else {
            let name = usernameexit()
            let user = try! Realm().objects(Users.self)
            //        username.text = name
            for item in user {
                if name == item.name {
                    print("原用户名：\(name)")
                    item.name = txt.text!
                    print("新用户名：\(name)")
                }
            }
        }
        
    }
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
