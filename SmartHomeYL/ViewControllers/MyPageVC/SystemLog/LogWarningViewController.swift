//
//  LogWarningViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/12.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class LogWarningViewController: UIViewController {
    
    //    var token : NotificationToken? = nil //监听
    var i = 0
    //屏幕宽度
    let w = UIScreen.main.bounds.width
    let scrollView = UIScrollView(frame:CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:588))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
        
        scrollView.backgroundColor = UIColor(red: 250/255, green: 246/255, blue: 237/255, alpha: 0.2)
        //scrollView大小
        scrollView.contentSize = CGSize(width:w,height:UIScreen.main.bounds.height)
        self.view.addSubview(scrollView)
        
        
        func drawItem(type:String,timing:String) {
            let itemView = UIView(frame:CGRect(x:10,y:i*180+25,width:355,height:150))
            itemView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
            itemView.layer.shadowOpacity = 0.5
            itemView.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.scrollView.addSubview(itemView)
            itemView.layer.cornerRadius = 5
            
            let time = UILabel(frame:CGRect(x:20,y:5,width:w,height:30))
            time.textColor = UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8)
            
            itemView.addSubview(time)
            
            let img = UIImageView(frame:CGRect(x:20,y:40,width:30,height:30))
            
            itemView.addSubview(img)
            
            let title = UILabel(frame:CGRect(x:55,y:40,width:w - 80,height:30))
            
            title.textColor = UIColor.red
            itemView.addSubview(title)
            
            let content = UILabel(frame:CGRect(x:20,y:75,width:w - 80,height:30))
            content.textColor = UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.7)
            itemView.addSubview(content)
            
            let details = UILabel(frame:CGRect(x:240,y:110,width:100,height:30))
            details.text = "查看详情 >>"
            details.textColor = UIColor(red: 106/255, green: 130/255, blue: 155/255, alpha: 1)
            itemView.addSubview(details)
            title.font = UIFont.systemFont(ofSize: 20)//调整文字大小
            
            
            switch type {
            case "红外警报":
                time.text = timing
                img.image = UIImage(named: "red")
                title.text = "红外警报❗️"
                content.text = "系统监测到红外感应"
                
            case "烟雾警报":
                time.text = timing
                img.image = UIImage(named: "xiangyan")
                title.text = "烟雾警报❗️"
                content.text = "系统监测到烟雾浓度超标"
//
            default:
                return
            }
            i += 1
            if(i>3){
                scrollView.contentSize.height += 180
            }
        }
        
        let realm = try! Realm()
        let items = realm.objects(logs.self)
        //反向排序，最后消息显示在最前面
        for item in items.reversed() {
            drawItem(type: item.type,timing:item.time)
        }
        
    }
    
    //提示
    func showMsgbox(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
}

