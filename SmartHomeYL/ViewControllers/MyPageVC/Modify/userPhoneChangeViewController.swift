//
//  userPhoneChangeViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/24.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class userPhoneChangeViewController: UIViewController {

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
//
//    @IBOutlet weak var phoneTxt: UITextField!
//    
//    
//    //判断username是否存在，存在即返回值，不存在即设为空
//    func usernameexit() -> String {
//        if (UserDefaults.standard.object(forKey: "userName") != nil) {
//            let username = UserDefaults.standard.object(forKey: "userName") as! String
//            return username
//        } else {
//            let username = ""
//            return username
//        }
//    }
    
//    func showMsgbox(_message: String, _title: String = "哎呀"){
//        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
//        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
//        alert.addAction(btnOK)
//        self.present(alert, animated: true, completion: nil)
//    }
    
//
//    @IBAction func submit(_ sender: Any) {
//        if phoneTxt.text == ""{
//            showMsgbox(_message: "手机号不能为空噢")
//            return
//        } else if phoneTxt.text!.count != 11{
//            showMsgbox(_message: "手机号格式错误")
//        } else {
//            let name = usernameexit()
//            let user = try! Realm().objects(Users.self)
//            //        username.text = name
//            for item in user {
//                if name == item.phone {
//                    print("原号码：\(name)")
//                    item.phone = phoneTxt.text!
//                    print("新号码：\(name)")
//                }
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
