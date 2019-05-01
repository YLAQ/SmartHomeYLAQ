//
//  AddExampleViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/27.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class AddExampleViewController: UIViewController {

    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
    }
    
    @IBAction func wd(_ sender: Any) {
        self.showMsgbox2(_message: "设备已连接(ˊo̶̶̷ᴗo̶̶̷`)")
    }
    
    @IBAction func sd(_ sender: Any) {
        self.showMsgbox2(_message: "设备已连接(ˊo̶̶̷ᴗo̶̶̷`)")
    }
    
    @IBAction func pm(_ sender: Any) {
        self.showMsgbox2(_message: "设备已连接(ˊo̶̶̷ᴗo̶̶̷`)")
    }
    
    @IBAction func led(_ sender: Any) {
        view.makeLoading(title: "正在连接LED灯...", enable: true)
        //延迟5秒执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.showMsgbox(_message: "设备连接成功(๑`▽´๑)۶")
            self.view.dismissLoading()
        }
    }
    
    @IBAction func redline(_ sender: Any) {
        view.makeLoading(title: "正在连接红外感应器...", enable: true)
        //延迟5秒执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.showMsgbox(_message: "设备连接成功(๑`▽´๑)۶")
            self.view.dismissLoading()
        }
    }
    
    @IBAction func smoke(_ sender: Any) {
        view.makeLoading(title: "正在连接烟雾报警器...", enable: true)
        //延迟5秒执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.showMsgbox(_message: "设备连接成功(๑`▽´๑)۶")
            self.view.dismissLoading()
        }
    }
    
    //提示
    func showMsgbox(_message: String, _title: String = "欧阔~"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMsgbox2(_message: String, _title: String = "连过啦"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
}

