//
//  RegisterViewModel.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/17.
//  Copyright © 2019 yu li. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel {
    
    //用户名验证结果
    let validatedUsername: Driver<ValidationResult>
    
    //电话验证结果
    let validatedPhone: Driver<ValidationResult>
    
    //密码验证结果
    let validatedPassword: Driver<ValidationResult>
    
    //再次输入密码验证结果
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    //注册按钮是否可用
    let signupEnabled: Driver<Bool>
    
    //注册结果
    let signupResult: Driver<Bool>
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(
        input: (
        username: Driver<String>,
        phone: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        loginTaps: Signal<Void>
        ),
        dependency: (
        networkService: RegisterNetworkService,
        signupService: RegisterService
        )) {
        
        //用户名验证
        validatedUsername = input.username
            .flatMapLatest { username in
                return dependency.signupService.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器发生错误!"))
        }
        
        //用户名电话验证
        validatedPhone = input.phone
            .map { phone in
                return dependency.signupService.validatePhone(phone)
        }
        
        //用户名密码验证
        validatedPassword = input.password
            .map { password in
                return dependency.signupService.validatePassword(password)
        }
        
        //重复输入密码验证
        validatedPasswordRepeated = Driver.combineLatest(
            input.password,
            input.repeatedPassword,
            resultSelector: dependency.signupService.validateRepeatedPassword)
        
        //注册按钮是否可用
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPhone,
            validatedPassword,
            validatedPasswordRepeated
        ) { username, phone, password, repeatPassword in
            username.isValid && phone.isValid && password.isValid && repeatPassword.isValid
            }
            .distinctUntilChanged()
        
        //获取最新的用户名和密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.phone,input.password) {
            (username: $0, phone: $1, password: $2) }
        
        //注册按钮点击结果
        signupResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in  //也可考虑改用flatMapFirst
                return dependency.networkService.signup(pair.username, phone: pair.phone,
                    password: pair.password)
                    .asDriver(onErrorJustReturn: false)
        }
    }
}
