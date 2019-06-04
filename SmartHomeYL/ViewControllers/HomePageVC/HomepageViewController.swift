//
//  HomepageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class HomepageViewController: UIViewController {
    
    //判断username是否存在，存在即返回值，不存在即设为空
    func usernameexit() -> String {
        if (UserDefaults.standard.object(forKey: "userName") != nil) {
            let username = UserDefaults.standard.object(forKey: "userName") as! String
            return username
        } else {
            let username = ""
            return username
        }
    }
    
    //UIViewController对象的视图已经加入到窗口时调用
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        let username = usernameexit()
        //username为空则跳转登录界面，存在则return
        if username == "" {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loginpage")
            
            self.tabBarController!.present(vc, animated: true, completion: nil)
            //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            //                print("时间2：", Date())
            //            }
        } else {
            print("当前用户为 \(username)")
            return
        }
    }
    
    
    @IBOutlet weak var weather: UIImageView! //天气
    @IBOutlet weak var userName: UILabel! //用户名
    @IBOutlet weak var date: UILabel! //日期
    @IBOutlet weak var tempLable: UILabel! //温度
    @IBOutlet weak var humiLable: UILabel! //湿度
    @IBOutlet weak var pmLable: UILabel! //pm2.5
    @IBOutlet weak var tips: UITextView! //小贴士
    @IBOutlet weak var scrollView: UIScrollView!
    var token : NotificationToken? = nil //监听
    var tokenlog : NotificationToken? = nil //监听
    
    
    //添加设备按钮点击
    @IBAction func addEquBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddDevicespage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"lgbg.jpg")!)
        weather.image = UIImage(named: "qingtian")
        userName.text = "\(usernameexit()) 的家"
        //获取当前时间
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        print("当前日期时间：\(dformatter.string(from: now)) \(week())")
        date.text = "\(dformatter.string(from: now))  \(week())"
        let realm = try! Realm()
    
        
        let states = realm.objects(dataState.self)
        if(states.count < 1){
            let item1 = dataState(value: [false,false,false,false])
            try! realm.write {
                realm.add(item1)
            }
        }
        
        scrollView.layer.cornerRadius = 10
        
        let result = realm.objects(getDatas.self)
        token = result.observe({ (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                //Results 现在已经填充完毕，可以不需要阻塞 UI 就可以被访问
                debugPrint("首页数据初始化")
                break
            case .update(_, deletions: _, insertions: _, modifications: _):
                //数据库发生更改（增删改）调用
                debugPrint("首页数据更新")
                
                //查询所有环境数据信息
                let items = realm.objects(getDatas.self)
                let itemstate = realm.objects(dataState.self)
                
                if(itemstate[0].tempState == true) {
                    self.tempLable.text = "\(items.last!.temprature)°C"
                } else {
                    self.tempLable.text = "暂无数据"
                }
                
                if(itemstate[0].humiState == true) {
                    self.humiLable.text = "\(items.last!.humidity)%RH"
                } else {
                    self.humiLable.text = "暂无数据"
                }
                
                if(itemstate[0].pmState == true) {
                    self.pmLable.text = "\(items.last!.pm )μg/m³"
                } else {
                    self.pmLable.text = "暂无数据"
                }
                break
            default:
                break
            }
        })
        
        let log = realm.objects(logs.self)
        tokenlog = log.observe({ (changes:  RealmCollectionChange) in
            switch changes {
            case .initial:
                break
            case .update(_, deletions: _, insertions: _, modifications: _):
                //数据库发生更改（增删改）调用
                debugPrint("首页数据更新")
                
                //查询所有环境数据信息
                let itemstate = realm.objects(logs.self)
                
                switch itemstate.last!.type {
                case "烟雾警报":
                    self.showMsgbox(_message: "系统监测到烟雾浓度超标，请检查房间内是否有物体燃烧", _title: "烟雾警报❗️")
                case "红外警报":
                    self.showMsgbox(_message: "系统监测到红外感应，请检查门窗是否有异常", _title: "红外警报❗️")
                default:
                    break
                }
            default:
                break
            }
        })
    }
    
    //判断星期函数
    func week() -> String {
        //获取当前时间
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "EEEE"
        switch dformatter.string(from: now) {
        case "Monday":
            return "星期一"
        case "Tuesday":
            return "星期二"
        case "Wednesday":
            return "星期三"
        case "Thursday":
            return "星期四"
        case "Friday":
            return "星期五"
        case "Saturday":
            return "星期六"
        case "Sunday":
            return "星期日"
        default:
            return "error"
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

