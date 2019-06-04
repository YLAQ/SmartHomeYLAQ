//
//  ScenepageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/25.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import LLCycleScrollView
import RealmSwift

class ScenepageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        //屏幕宽度
        let w = UIScreen.main.bounds.width
        let scrollView = UIScrollView(frame:CGRect(x:0,y:0,width:w,height:588))
        scrollView.backgroundColor = UIColor(red: 250/255, green: 246/255, blue: 237/255, alpha: 0.5)
        //scrollView大小
        scrollView.contentSize = CGSize(width:w,height:1180)
        self.view.addSubview(scrollView)
        //banner
        let imagesURLStrings = [
            "bn1","bn2","bn3","bn4","bn5"
        ]
        let banner = LLCycleScrollView.llCycleScrollViewWithArrow(CGRect.init(x: 0, y: 0, width: w, height: 200), arrowLRImages: [UIImage.init(named: "zuojiantou")!, UIImage.init(named: "youjiantou")!], imageURLPaths: imagesURLStrings, titles:nil, didSelectItemAtIndex: { index in
            //            print("当前点击图片的位置为:\(index)")
        })
        banner.lldidSelectItemAtIndex = { index in
        }
        // 滚动间隔时间(默认为2秒)
        banner.autoScrollTimeInterval = 3.0
        // 设置当前PageControl的样式
        banner.customPageControlStyle = .snake
        // 非.system的状态下，设置PageControl的tintColor
        banner.customPageControlInActiveTintColor = UIColor(r: 211, g: 211, b: 211)
        // 设置PageControl的位置
        banner.pageControlPosition = .center
        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        banner.customPageControlIndicatorPadding = 8.0
        banner.pageControlLeadingOrTrialingContact = 28
        scrollView.addSubview(banner)
        
        //一键执行
        let buttonyj = UIButton.init(type: .custom)
        //将按钮添加到视图中
        scrollView.addSubview(buttonyj)
        buttonyj.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.9),for: .normal)
        buttonyj.frame = CGRect.init(x: 0, y: 220, width: 80, height: 30)
        buttonyj.setTitle("一键执行", for: .normal)
        
        //日出关灯
        let sunrisebtn = UIButton.init(type: .custom)
        sunrisebtn.frame = CGRect.init(x: 0, y: buttonyj.ll_y + 30, width: w, height: 150)
        sunrisebtn.setImage(UIImage(named:"sunrise"), for: .normal)
        scrollView.addSubview(sunrisebtn)
        //按钮点击操作
        sunrisebtn.addTarget(self, action:#selector(sunrise(sender:)), for: .touchUpInside)
        
        //文字说明
        let buttonrc = UIButton.init(type: .custom)
        scrollView.addSubview(buttonrc)
        buttonrc.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonrc.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.3)
        buttonrc.frame = CGRect.init(x: 0, y: sunrisebtn.ll_y + 120, width: w , height: 30)
        buttonrc.setTitle("日出时关灯", for: .normal)
        
        //天黑开灯
        let sunsetbtn = UIButton.init(type: .custom)
        sunsetbtn.frame = CGRect.init(x: 0, y: sunrisebtn.ll_y + 155, width: w, height: 150)
        sunsetbtn.setImage(UIImage(named:"night"), for: .normal)
        scrollView.addSubview(sunsetbtn)
        //按钮点击操作
        sunsetbtn.addTarget(self, action:#selector(sunset(sender:)), for: .touchUpInside)
        
        //文字说明
        let buttonrl = UIButton.init(type: .custom)
        scrollView.addSubview(buttonrl)
        buttonrl.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonrl.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.3)
        buttonrl.frame = CGRect.init(x: 0, y: sunsetbtn.ll_y + 120, width: w , height: 30)
        buttonrl.setTitle("天黑时开灯", for: .normal)
        
        
        //开风扇
        let fanon = UIButton.init(type: .custom)
        fanon.frame = CGRect.init(x: 0, y: sunsetbtn.ll_y + 155, width: w, height: 150)
        fanon.setImage(UIImage(named:"fanon"), for: .normal)
        scrollView.addSubview(fanon)
        //按钮点击操作
        fanon.addTarget(self, action:#selector(fanonfunc(sender:)), for: .touchUpInside)
        
        //文字说明
        let fanontxt = UIButton.init(type: .custom)
        scrollView.addSubview(fanontxt)
        fanontxt.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        fanontxt.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.3)
        fanontxt.frame = CGRect.init(x: 0, y: fanon.ll_y + 120, width: w , height: 30)
        fanontxt.setTitle("开启风扇", for: .normal)
        
        //关风扇
        let fanoff = UIButton.init(type: .custom)
        fanoff.frame = CGRect.init(x: 0, y: fanon.ll_y + 155, width: w, height: 150)
        fanoff.setImage(UIImage(named:"fanoff"), for: .normal)
        scrollView.addSubview(fanoff)
        //按钮点击操作
        fanoff.addTarget(self, action:#selector(fanofffunc(sender:)), for: .touchUpInside)
        
        //文字说明
        let fanofftxt = UIButton.init(type: .custom)
        scrollView.addSubview(fanofftxt)
        fanofftxt.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        fanofftxt.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.3)
        fanofftxt.frame = CGRect.init(x: 0, y: fanoff.ll_y + 120, width: w , height: 30)
        fanofftxt.setTitle("关闭风扇", for: .normal)
        
        //文字说明
        let buttonzn = UIButton.init(type: .custom)
        //将按钮添加到视图中
        scrollView.addSubview(buttonzn)
        buttonzn.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonzn.frame = CGRect.init(x: 0, y: fanoff.ll_y + 170, width: 80, height: 30)
        buttonzn.setTitle("智能编排", for: .normal)
        
        //智能编排
        let diybtn = UIButton.init(type: .custom)
        diybtn.frame = CGRect.init(x: 0, y: buttonzn.ll_y + 30, width: w, height: 200)
        diybtn.setImage(UIImage(named:"diy"), for: .normal)
        scrollView.addSubview(diybtn)
        //点击事件
        diybtn.addTarget(self, action:#selector(diy(sender:)), for: .touchUpInside)
        //文字说明
        let buttonsun = UIButton.init(type: .custom)
        scrollView.addSubview(buttonsun)
        buttonsun.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonsun.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.7)
        buttonsun.frame = CGRect.init(x: 0, y: diybtn.ll_y + 170, width: w , height: 30)
        buttonsun.setTitle("定制属于您自己的智能编排", for: .normal)
    }
    
    
    //点击事件
    //关灯
    @objc func sunrise(sender:UIButton){
        //        ble.postData = "B"
        //查询所有记录
        let realm = try! Realm()
        let itemstate = realm.objects(dataState.self)
        if(itemstate[0].lightState == true) {
            ble.didClickPost(postData: "C")
            print("日出关灯")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.showMsgbox(_message: "已将所有灯关闭~",_title: "操作成功")
            }
        } else {
            self.showMsgbox(_message: "请先连接Arduino设备哦~",_title: "操作失败")
        }
        
    }
    //开灯
    @objc func sunset(sender:UIButton){
        //        ble.didClickPost(postData: "B")
        print("日落开灯")
        //查询所有记录
        let realm = try! Realm()
        let itemstate = realm.objects(dataState.self)
        if(itemstate[0].lightState == true) {
            ble.didClickPost(postData: "B")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.showMsgbox(_message: "已将所有灯开启~",_title: "操作成功")
            }
        } else {
            self.showMsgbox(_message: "请先连接Arduino设备哦~",_title: "操作失败")
        }
    }
    
    //开风扇
    @objc func fanonfunc(sender:UIButton){
        //        ble.didClickPost(postData: "B")
        print("打开风扇")
        //查询所有记录
        let realm = try! Realm()
        let itemstate = realm.objects(dataState.self)
        if(itemstate[0].fanState == true) {
            ble.didClickPost(postData: "D")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.showMsgbox(_message: "已将风扇开启~",_title: "操作成功")
            }
        } else {
            self.showMsgbox(_message: "请先连接Arduino设备哦~",_title: "操作失败")
        }
    }
    
    //关风扇
    @objc func fanofffunc(sender:UIButton){
        //        ble.postData = "B"
        //查询所有记录
        let realm = try! Realm()
        let itemstate = realm.objects(dataState.self)
        if(itemstate[0].fanState == true) {
            ble.didClickPost(postData: "E")
            print("关闭风扇")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.showMsgbox(_message: "已将风扇关闭~",_title: "操作成功")
            }
        } else {
            self.showMsgbox(_message: "请先连接Arduino设备哦~",_title: "操作失败")
        }
        
    }
    
    //智能编排
    @objc func diy(sender:UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DesignItempage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
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

