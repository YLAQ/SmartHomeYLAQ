//
//  RedLineViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/28.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class RedLineViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.img.image = UIImage(named: "red")
            self.lable.text = "警报：有人靠近！"
            self.lable.textColor = UIColor.red
            self.showMsgbox(_message: "请注意，红外警报已被触发！",_title: "警报")
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 15) {
            self.img.image = UIImage(named: "green")
            self.lable.text = "安全~无人在附近"
            self.lable.textColor = UIColor.green
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 27) {
            self.img.image = UIImage(named: "red")
            self.lable.text = "警报：有人靠近！"
            self.lable.textColor = UIColor.red
            self.showMsgbox(_message: "请注意，红外警报已被触发！",_title: "警报")
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //提示
    func showMsgbox(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
}
