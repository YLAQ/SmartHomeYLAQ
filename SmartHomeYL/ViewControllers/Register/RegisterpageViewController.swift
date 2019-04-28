//
//  RegisterpageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/17.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift
import RxCocoa
import RxSwift

class RegisterpageViewController: UIViewController {

    //用户名输入框、以及验证结果显示标签
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidationOutlet: UILabel!
    
    //手机号输入框、以及验证结果显示标签
    @IBOutlet weak var userphoneOutlet: UITextField!
    @IBOutlet weak var phoneValidationOutlet: UILabel!
    
    //密码输入框、以及验证结果显示标签
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidationOutlet: UILabel!
    
    //重复密码输入框、以及验证结果显示标签
    @IBOutlet weak var repeatedPasswordOutlet: UITextField!
    @IBOutlet weak var repeatedPasswordValidationOutlet: UILabel!
    
    //注册按钮
    @IBOutlet weak var signupOutlet: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        //用户名
        usernameOutlet.layer.cornerRadius = 5
        usernameOutlet.layer.borderColor = UIColor.lightGray.cgColor
        usernameOutlet.layer.borderWidth = 0.5
        usernameOutlet.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        usernameOutlet.leftViewMode = UITextField.ViewMode.always
        usernameOutlet.placeholder = "请输入用户名"
        usernameOutlet.clearButtonMode = .whileEditing
        let imgUser1 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser1.image = UIImage(named:"yh")
        usernameOutlet.leftView!.addSubview(imgUser1)
        //手机号
        userphoneOutlet.layer.cornerRadius = 5
        userphoneOutlet.layer.borderColor = UIColor.lightGray.cgColor
        userphoneOutlet.layer.borderWidth = 0.5
        userphoneOutlet.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        userphoneOutlet.leftViewMode = UITextField.ViewMode.always
        userphoneOutlet.placeholder = "请输入手机号"
        userphoneOutlet.clearButtonMode = .whileEditing
        //用户名输入框左侧图标
        let imgUser2 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser2.image = UIImage(named:"sj")
        userphoneOutlet.leftView!.addSubview(imgUser2)
        //密码
        passwordOutlet.layer.cornerRadius = 5
        passwordOutlet.layer.borderColor = UIColor.lightGray.cgColor
        passwordOutlet.layer.borderWidth = 0.5
        passwordOutlet.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        passwordOutlet.leftViewMode = UITextField.ViewMode.always
        passwordOutlet.placeholder = "请输入密码"
        passwordOutlet.isSecureTextEntry = true
        passwordOutlet.clearButtonMode = .whileEditing
        let imgUser3 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser3.image = UIImage(named:"mm")
        passwordOutlet.leftView!.addSubview(imgUser3)
        //再次密码
        repeatedPasswordOutlet.layer.cornerRadius = 5
        repeatedPasswordOutlet.layer.borderColor = UIColor.lightGray.cgColor
        repeatedPasswordOutlet.layer.borderWidth = 0.5
        repeatedPasswordOutlet.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        repeatedPasswordOutlet.leftViewMode = UITextField.ViewMode.always
        repeatedPasswordOutlet.placeholder = "请再次输入密码"
        repeatedPasswordOutlet.isSecureTextEntry = true
        repeatedPasswordOutlet.clearButtonMode = .whileEditing
        let imgUser4 =  UIImageView(frame:CGRect(x:  11, y: 11, width: 22, height: 22))
        imgUser4.image = UIImage(named:"mm")
        repeatedPasswordOutlet.leftView!.addSubview(imgUser4)
        
        //初始化ViewModel
        let viewModel = RegisterViewModel(
            input: (
                username: usernameOutlet.rx.text.orEmpty.asDriver(),
                phone: userphoneOutlet.rx.text.orEmpty.asDriver(),
                password: passwordOutlet.rx.text.orEmpty.asDriver(),
                repeatedPassword: repeatedPasswordOutlet.rx.text.orEmpty.asDriver(),
                loginTaps: signupOutlet.rx.tap.asSignal()
            ),
            dependency: (
                networkService: RegisterNetworkService(),
                signupService: RegisterService()
            )
        )
        
        //用户名验证结果绑定
        viewModel.validatedUsername
            .drive(usernameValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        //电话验证结果绑定
        viewModel.validatedPhone
            .drive(phoneValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        //密码验证结果绑定
        viewModel.validatedPassword
            .drive(passwordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        //再次输入密码验证结果绑定
        viewModel.validatedPasswordRepeated
            .drive(repeatedPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        //注册按钮是否可用
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid  in
                self?.signupOutlet.isEnabled = valid
                self?.signupOutlet.alpha = valid ? 1.0 : 0.3
            })
            .disposed(by: disposeBag)
        
        //注册结果绑定
        viewModel.signupResult
            .drive(onNext: { [unowned self] result in
                self.showMessage("注册" + (result ? "成功" : "失败") + "!")
                //用户信息存入数据库
                let realm = try! Realm()
                let user = Users()
                user.name = self.usernameOutlet.text!
                user.phone = self.userphoneOutlet.text!
                user.password = self.passwordOutlet.text!
                    
                try! realm.write {
                    realm.add(user)
                }
                //打印出数据库地址
                print(realm.configuration.fileURL ?? "")
//                self.dismiss(animated: false, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    //详细提示框
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: { //点击确定返回登录界面
            action in
            self.dismiss(animated: false, completion: nil)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
