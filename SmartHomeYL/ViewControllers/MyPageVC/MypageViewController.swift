//
//  MypageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class MypageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var token : NotificationToken? = nil
    @IBOutlet weak var username: UILabel! //用户名
    @IBOutlet weak var tel: UILabel! //手机号
    @IBOutlet weak var hp: UIImageView! //头像
    @IBOutlet weak var table: UITableView! //tableview
    var allnames:Dictionary<Int, [String]>? //cell名称
    @IBOutlet weak var logout: UIButton! //退出登录按钮
    //cell图片
    var count = 0
    var imgs:[String] = ["jiating","xiaoxi","bangzhu","appstore","shezhi"]
    
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
    
    override func loadView() {
        super.loadView()
        
        //用户名、电话
        let name = usernameexit()
        //使用默认的数据库
        let realm = try! Realm()
        //查询所有用户信息
        let items = realm.objects(Users.self)
        //打印出数据库地址
        print(realm.configuration.fileURL ?? "")
        
        username.text = name
        tel.text = ""
        for item in items {
            if name == item.name {
                tel.text = item.phone
            }
        }
        
        //用户头像
        hp.image = UIImage(named: "hp")
        hp.layer.cornerRadius = 33
        
        logout.layer.cornerRadius = 10
        logout.layer.shadowOpacity = 0.5
        logout.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
        //数据库监听
        let result = realm.objects(Users.self)
        token = result.observe({ (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                //Results 现在已经填充完毕，可以不需要阻塞 UI 就可以被访问
                debugPrint("用户信息初始化")
                break
            case .update(_, deletions: _, insertions: _, modifications: _):
                //数据库发生更改（增删改）调用
                debugPrint("用户信息更新")
                //用户名、电话
                let name = self.usernameexit()
                //使用默认的数据库
                let realm = try! Realm()
                //查询所有用户信息
                let items = realm.objects(Users.self)
                
                self.username.text = name
                for item in items {
                    if name == item.name {
                        self.tel.text = item.phone
                    }
                }
                break
            default:
                break
            }
        })
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        showMsgboxCancle(_message: "您确定要退出登录吗",_title: "退出登录")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"lgbg.jpg")!)
        
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.allnames =  [
            0:[String]([
                "家庭管理"]),
            1:[String]([
                "消息中心"]),
            2:[String]([
                "帮助与反馈",
                "去评分"]),
            3:[String]([
                "设置"])
        ];
        
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "SwiftCell")
        //分隔线
        table.separatorColor = UIColor.clear
        table.backgroundColor = UIColor.clear
        
    }
    //分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.allnames?[section]
        return data!.count
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的尾部
    func tableView(_ tableView:UITableView, titleForFooterInSection section:Int)->String? {
        //        let data = self.allnames?[section]
        return " "
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        //        footerView.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 216/255, alpha: 0.9)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identify, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        let secno = indexPath.section
        var data = self.allnames?[secno]
        cell.textLabel?.text = data![indexPath.row]
        //cell图片
        cell.imageView!.image = UIImage(named:imgs[count])
        count = count + 1
        
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        
        
        //        //选中背景修改成绿色
        //        cell.selectedBackgroundView = UIView()
        //        cell.selectedBackgroundView?.backgroundColor =
        //            UIColor(red: 135/255, green: 191/255, blue: 49/255, alpha: 1)
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        table.deselectRow(at: indexPath, animated: true)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        switch itemString {
        //家庭管理
        case "家庭管理":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FamilyManagepage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //消息中心
        case "消息中心":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SystemLogpage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //帮助与反馈
        case "帮助与反馈":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Feedbackpage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //去评分
        case "去评分":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppStorepage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //设置
        case "设置":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetUppage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
            
        default:
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //带取消的提示
    func showMsgboxCancle(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnCancle = UIAlertAction(title: "点错啦", style: .cancel, handler: nil)
        let btnOK = UIAlertAction(title: "我要退出", style: .default, handler: {
            action in
            //删除当前UserDefaults，退出用户
            UserDefaults.standard.setValue("", forKey: "userName")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loginpage")
            //返回Loginpage
            self.present(vc, animated: true, completion: nil)
        })
        alert.addAction(btnOK)
        alert.addAction(btnCancle)
        self.present(alert, animated: true, completion: nil)
    }
}
