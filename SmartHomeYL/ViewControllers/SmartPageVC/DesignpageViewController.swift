//
//  DesignpageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/26.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class DesignpageViewController: UIViewController {
    
//    var mark = ""
    //屏幕宽度
    let w = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func add(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DesignItempage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    func drawItem(passtitle:String) {
        let itemView =
            UIImageView(frame:CGRect(x:16,y:80,width:343,height:180))
        itemView.image = UIImage(named: "znbpimg")
        itemView.layer.masksToBounds = true
        itemView.layer.cornerRadius = 10
        self.view.addSubview(itemView)
        
        let black =  UIView(frame:CGRect(x:16,y:80,width:343,height:180))
        black.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        black.layer.cornerRadius = 10
        self.view.addSubview(black)
        
        let title = UILabel(frame:CGRect(x:48,y:105,width:205,height:35))
        title.font = UIFont.systemFont(ofSize: 23)
        title.text = passtitle
        title.textColor = UIColor.white
        self.view.addSubview(title)


        let swt = UISwitch(frame:CGRect(x:279,y:110,width:49,height:31))
        self.view.addSubview(swt)
        
    }
    //开关回调事件，注意“_”下划线与sender之间要有空格
    @objc func switchStateDidChange(_ sender : UISwitch){
        if(sender.isOn == true){
            print("UISwitch state is ON")
            
        }else{
            print("UISwitch state is OFF")
        }
    }

}
