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
    
    //添加设备按钮点击
    @IBAction func addEquBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEquipmentpage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named:"lgbg.jpg")!)
        weather.image = UIImage(named: "zhongyu")
        userName.text = "\(usernameexit()) 的家"
        //获取当前时间
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd"
        print("当前日期时间：\(dformatter.string(from: now)) \(week())")
        date.text = "\(dformatter.string(from: now))  \(week())"
        
        
//        tips.layer.borderWidth = 0.5
//        tips.layer.borderColor = UIColor.lightGray.cgColor
//        tips.layer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5).cgColor
//        tips.layer.cornerRadius = 5
//        tips.layer.shadowOpacity = 0.8//设置阴影透明度
//        tips.layer.shadowOffset = CGSize(width: 2, height: 2)//设置阴影偏移量
        scrollView.layer.cornerRadius = 10
        
        //数据库监听
        let realm = try! Realm()
//        try! realm.write {
//            realm.deleteAll()
//        }
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
                self.tempLable.text = "\(items.last!.temprature)°C"
                self.humiLable.text = "\(items.last!.humidity)%RH"
                self.pmLable.text = "\(items.last!.pm)μg/m³"
                break
            default:
                break
            }
        })
    }
    
    //小贴士
//    func tips() -> String {
//        if <#condition#> {
//            <#code#>
//        }
//    }
    
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
    
}

