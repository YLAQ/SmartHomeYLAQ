//
//  LogInformsViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/12.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class LogInformsViewController: UIViewController {

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
            
            itemView.addSubview(time)
            
            let img = UIImageView(frame:CGRect(x:20,y:40,width:30,height:30))
            
            itemView.addSubview(img)
            
            let title = UILabel(frame:CGRect(x:55,y:40,width:w - 80,height:30))
            
            title.textColor = UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 1)
            itemView.addSubview(title)
            
            let content = UILabel(frame:CGRect(x:20,y:75,width:w - 80,height:30))
            content.textColor = UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.7)
            itemView.addSubview(content)
            
            let details = UILabel(frame:CGRect(x:240,y:110,width:100,height:30))
            details.text = "查看详情 >>"
            details.textColor = UIColor(red: 106/255, green: 130/255, blue: 155/255, alpha: 1)
            itemView.addSubview(details)
            
            time.textColor = UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8)
            title.font = UIFont.systemFont(ofSize: 19)//调整文字大小
            
            
            switch type {
            case "更新":
                time.text = timing
                img.image = UIImage(named: "shezhi")
                title.text = "系统更新"
                content.text = "智能家居app2.0可用于更新"
            case "消息":
                time.text = timing
                img.image = UIImage(named: "tongzhi")
                title.text = "您的反馈我们已经收到并改进"
                content.text = "感谢您的反馈"
            default:
                return
            }
            i += 1
        }
        drawItem(type: "消息",timing:"2019-5-15 11:32")
        drawItem(type: "更新",timing:"2019-5-17 19:01")
    }

}
