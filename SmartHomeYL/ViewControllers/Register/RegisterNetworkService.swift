//
//  RegisterNetworkService.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/17.
//  Copyright © 2019 yu li. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import RealmSwift


//注册网络请求服务
class RegisterNetworkService {
    //验证用户是否存在
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        var usernameRight = true
        let realm = try! Realm()
        //查询用户名是否已经存在
        let items = realm.objects(Users.self)
        for item in items {
            if item.name == username{
                usernameRight = false
            }
        }
        return Observable.just(usernameRight).self
    }
    
    //可注册用户
    func signup(_ username: String, phone: String, password: String) -> Observable<Bool> {
        //没有真正去发起请求，而是模拟这个操作（平均每3次有1次失败）
        let signupSucceed = true
        return Observable.just(signupSucceed).self
    }

}

//扩展String
extension String {
    //字符串的url地址转义
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

//验证结果和信息的枚举
enum ValidationResult {
    case validating  //正在验证中
    case empty  //输入为空
    case ok(message: String) //验证通过
    case failed(message: String)  //验证失败
}

//扩展ValidationResult，对应不同的验证结果返回验证是成功还是失败
extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

//扩展ValidationResult，对应不同的验证结果返回不同的文字描述
extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .validating:
            return "正在验证..."
        case .empty:
            return ""
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }
}

//扩展ValidationResult，对应不同的验证结果返回不同的文字颜色
extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .validating:
            return UIColor.gray
        case .empty:
            return UIColor.black
        case .ok:
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1)
        case .failed:
            return UIColor.red
        }
    }
}
