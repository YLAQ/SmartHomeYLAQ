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
    @IBOutlet weak var lable: UILabel!
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        lable.text = ""
        lable.textColor = UIColor.red
        
        txt.layer.cornerRadius = 5
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 0.5
        txt.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        txt.leftViewMode = UITextField.ViewMode.always
        txt.placeholder = "输入用户名"
        txt.clearButtonMode = .whileEditing
        //用户名输入框左侧图标
        let imgUser =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named:"yh")
        txt.leftView!.addSubview(imgUser)

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
        if txt.text == ""{
            lable.text = "用户名不能为空"
//            showMsgbox(_message: "用户名不能为空噢")
            return
        } else if txt.text!.count < 4{
            lable.text = "用户名长度为4-10个字符"
        } else if txt.text!.count > 10{
            lable.text = "用户名长度为4-10个字符"
        } else {
            let name = usernameexit()
            let realm = try! Realm()
//            let user = Users()
            let user = try! Realm().objects(Users.self)
            
            for item in user {
                if name == item.name {
                    print("原用户名：\(item.name)")
                    try! realm.write  {
                        item.name = txt.text!
                    }
                    print("新用户名：\(item.name)")
                    //保存用户名
                    UserDefaults.standard.setValue(txt.text!, forKey: "userName")
                }
            }
            showMsgboxwc(_message: "用户名修改成功")
        
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
