//
//  RegisterService.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/17.
//  Copyright © 2019 yu li. All rights reserved.
//

import Foundation
import RxSwift

//用户注册服务
class RegisterService {
    
    //密码最少位数
    let minPasswordCount = 5
    
    //网络请求服务
    lazy var networkService = {
        return RegisterNetworkService()
    }()
    
    //验证用户名
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        //判断用户名是否为空
        if username.isEmpty {
            return .just(.empty)
        }
        
        let numberOfCharacters = username.count
        //判断用户名位数
        if numberOfCharacters < 4{
            return .just(.failed(message: "用户名长度为4-10个字符"))
        }
        if numberOfCharacters > 10{
            return .just(.failed(message: "用户名长度为4-10个字符"))
        }
        
        //判断用户名是否只有数字和字母
//        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
//            return .just(.failed(message: "用户名只能包含数字和字母"))
//        }
        
        //发起网络请求检查用户名是否已存在
        return networkService
            .usernameAvailable(username)
            .map { available in
                //根据查询情况返回不同的验证结果
                if available {
                    return .ok(message: "用户名可用")
                } else {
                    return .failed(message: "用户名已存在")
                }
            }
            .startWith(.validating) //在发起网络请求前，先返回一个“正在检查”的验证结果
    }
    
    //判断是否数字
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    //验证电话
    func validatePhone(_ phone: String) -> ValidationResult {
        let numberOfCharacters = phone.count
        
        //判断电话是否为空
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if isPurnInt(string: phone) == false {
            return .failed(message: "电话号码格式有误")
        }
        
        //判断电话位数
        if numberOfCharacters != 11 {
            return .failed(message: "电话号码格式有误")
        }
        
        //返回验证成功的结果
        return .ok(message: "电话号码有效")
    }
    
    //验证密码
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        
        //判断密码是否为空
        if numberOfCharacters == 0 {
            return .empty
        }
        
        //判断密码位数
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码至少需要 \(minPasswordCount) 个字符")
        }
        
        //返回验证成功的结果
        return .ok(message: "密码有效")
    }
    
    //验证二次输入的密码
    func validateRepeatedPassword(_ password: String, repeatedPassword: String)
        -> ValidationResult {
            //判断密码是否为空
            if repeatedPassword.count == 0 {
                return .empty
            }
            
            //判断两次输入的密码是否一致
            if repeatedPassword == password {
                return .ok(message: "密码有效")
            } else {
                return .failed(message: "两次输入的密码不一致")
            }
    }
}
