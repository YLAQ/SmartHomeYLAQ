//
//  userPassChangeViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/24.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class userPassChangeViewController: UIViewController {
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var lable2: UILabel!
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lable1.text = ""
        lable2.text = ""
        lable1.textColor = UIColor.red
        lable2.textColor = UIColor.red
        
        let realm = try! Realm()
        //打印出数据库地址
        print(realm.configuration.fileURL ?? "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
    
    @IBAction func submit(_ sender: Any) {
        if txt1.text == ""{
            lable1.text = "密码不能为空"
            //            showMsgbox(_message: "用户名不能为空噢")
            return
        } else if txt1.text!.count < 5{
            lable1.text = "密码至少需要5个字符"
        } else if txt2.text! != txt1.text!{
            lable1.text = ""
            lable2.text = "两次输入的密码不一致"
        } else {
            let name = usernameexit()
            let realm = try! Realm()
            let user = try! Realm().objects(Users.self)
            
            for item in user {
                if name == item.name {
                    print("原密码：\(item.password)")
                    try! realm.write  {
                        item.password = txt1.text!
                    }
                    print("新密码：\(item.password)")
                    
                }
            }
            showMsgboxwc(_message: "密码修改成功")
            
        }
    }
    
    func showMsgbox(_message: String, _title: String = "哎呀"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    } 
    
    func showMsgboxwc(_message: String, _title: String = "搞定~"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
}
