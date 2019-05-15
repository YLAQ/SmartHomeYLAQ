//
//  LoadingpageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/7.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import CoreBluetooth
import RealmSwift



class LoadingpageViewController: UIViewController {
    
    var loadId = ""
//    var connect = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.view.makeLoading(title: "正在连接...", enable: true)
        }

        switch self.loadId {
        case "温度传感器":
            //            print("xxx\(self.bluetooth)")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.view.dismissLoading()
                self.showMsgbox(_message: "快去首页查看数据吧~",_title: "设备连接成功(๑`▽´๑)۶")
            }
        case "湿度传感器":
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.view.dismissLoading()
                self.showMsgbox(_message: "快去首页查看数据吧~",_title: "设备连接成功(๑`▽´๑)۶")
            }
            
        case "PM2.5传感器":
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.view.dismissLoading()
                self.showMsgbox(_message: "快去首页查看数据吧~",_title: "设备连接成功(๑`▽´๑)۶")
            }
            
        case "红外传感器":
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.view.dismissLoading()
                self.showMsgbox(_message: "快去首页查看数据吧~",_title: "设备连接成功(๑`▽´๑)۶")
            }
        case "风扇":
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.view.dismissLoading()
                self.showMsgbox(_message: "快去首页查看数据吧~",_title: "设备连接成功(๑`▽´๑)۶")
            }
            
        case "暂无":
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.view.dismissLoading()
                self.showMsgbox(_message: "请先选择已有设备(⁎⁍̴̛ᴗ⁍̴̛⁎)",_title: "该设备暂未开放")
            }
            self.dismiss(animated: true, completion: nil)
        default:
            return
        }
        
        
        
    }
    
    
    //提示
    func showMsgbox(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    //带取消的提示
    func showMsgboxCancle(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnCancle = UIAlertAction(title: "再想想", style: .cancel, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        })
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            ble.stopYLble()
            self.view.dismissLoading()
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(btnOK)
        alert.addAction(btnCancle)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}




