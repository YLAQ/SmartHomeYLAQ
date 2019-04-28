//
//  LoginpageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift
class LoginpageViewController: UIViewController, UITextFieldDelegate {
    
    //用户密码输入框
    var txtUser:UITextField!
    var txtPwd:UITextField!
    var loginButton:UIButton!
    var registerButton:UIButton!
    
    //左手离脑袋的距离
    var offsetLeftHand:CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    
    //登录框状态
    var showType:LoginShowType = LoginShowType.NONE
    //输入为空提示
    func showMsgbox(_message: String, _title: String = "哎呀"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    //登录点击事件
    @objc func handleLogin(sender:UIButton){
        if txtUser.text == ""{
            showMsgbox(_message: "帐号不能为空噢")
            return
        }
        if txtPwd.text == ""{
            showMsgbox(_message: "密码不能为空噢")
            return
        }
        let user = try! Realm().objects(Users.self)
        //判断用户是否存在数据库
        if user.count == 0 {
            showMsgbox(_message: "不存在该用户，请先注册~")
        } else {
            for item in user {
                if txtUser.text == item.name && txtPwd.text == item.password{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tabpage")
                    //推出新的Controller
                    self.present(vc, animated: true, completion: nil)
                    //保存用户名
                    UserDefaults.standard.setValue(item.name, forKey: "userName")
                } else {
                    showMsgbox(_message: "帐号或密码输入错误")
                    return
                }
            }
        }
        
    }
    
    //注册点击事件
    @objc func handleRegister(sender:UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Registerpage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.view.layer.contents = UIImage(named: "bg")?.cgImage
        
        //获取屏幕尺寸
        let mainSize = UIScreen.main.bounds.size
        
        //猫头鹰头部
        let imgLogin =  UIImageView(frame:CGRect(x: mainSize.width/2-211/2, y: 50, width: 211, height: 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRect(x: 61 - offsetLeftHand, y: 90, width: 40, height: 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //猫头鹰右手(遮眼睛的)
        let rectRightHand = CGRect(x: imgLogin.frame.size.width / 2 + 60, y: 90, width: 40, height: 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        //登录框背景
        let vLogin =  UIView(frame:CGRect(x: 15, y: 150, width: mainSize.width - 30, height: 260))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRect(x: mainSize.width / 2 - 100,
                                      y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRect(x: mainSize.width / 2 + 62,
                                       y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
        
        //用户名输入框
        txtUser = UITextField(frame:CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        txtUser.delegate = self
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        txtUser.leftViewMode = UITextField.ViewMode.always
        txtUser.placeholder = "请输入用户名"
        txtUser.clearButtonMode = .whileEditing  //编辑时出现清除按钮
//        txtUser.becomeFirstResponder() //键盘弹出
//        txtUser.returnKeyType = UIReturnKeyType.done //表示完成输入
        
        //用户名输入框左侧图标
        let imgUser =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named:"iconfont-user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        //登录按钮
        loginButton = UIButton(frame:CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        loginButton.layer.cornerRadius = 5
        loginButton.layer.backgroundColor = #colorLiteral(red: 0.5058007836, green: 0.3391279876, blue: 0.2432400584, alpha: 1)
        loginButton.frame = CGRect(x:30, y:150, width: vLogin.frame.size.width - 60, height:44)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)//普通状态下文字的颜色
        loginButton.setTitleColor(UIColor.lightGray, for: .highlighted) //触摸状态下文字的颜色
        vLogin.addSubview(loginButton)
        //点击事件
        loginButton.addTarget(self, action:#selector(handleLogin(sender:)), for: .touchUpInside)
        
        //注册按钮
        registerButton = UIButton(frame:CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        registerButton.layer.cornerRadius = 5
        registerButton.frame = CGRect(x:130, y:200, width: vLogin.frame.size.width - 60, height:44)
        registerButton.setTitle("点我注册", for: .normal)
        registerButton.setTitleColor(UIColor.brown, for: .normal)//普通状态下文字的颜色
        registerButton.setTitleColor(UIColor.gray, for: .highlighted) //触摸状态下文字的颜色
        vLogin.addSubview(registerButton)
        //点击事件
        registerButton.addTarget(self, action:#selector(handleRegister(sender:)), for: .touchUpInside)
        
        
        
        //密码输入框
        txtPwd = UITextField(frame:CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44)) //边框
        txtPwd.delegate = self
        txtPwd.layer.cornerRadius = 5 //圆角半径
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.isSecureTextEntry = true
        txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = UITextField.ViewMode.always
        txtPwd.placeholder = "请输入密码"
        txtPwd.clearButtonMode = .whileEditing  //编辑时出现清除按钮
//        txtPwd.becomeFirstResponder() //键盘弹出
//        txtPwd.returnKeyType = UIReturnKeyType.done //表示完成输入
        
        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named:"iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)

    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        //如果当前是用户名输入
        if textField.isEqual(txtUser){
            if (showType != LoginShowType.PASS)
            {
                showType = LoginShowType.USER
                return
            }
            showType = LoginShowType.USER
            
            //播放不遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y + 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x + 48,
                    y: self.imgRightHand.frame.origin.y + 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x - 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 40, height: 40)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x + 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 40, height: 40)
            })
        }
            //如果当前是密码名输入
        else if textField.isEqual(txtPwd){
            if (showType == LoginShowType.PASS)
            {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
            
            //播放遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y - 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x - 48,
                    y: self.imgRightHand.frame.origin.y - 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x + 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 0, height: 0)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x - 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 0, height: 0)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//登录框状态枚举
enum LoginShowType {
    case NONE
    case USER
    case PASS
}







