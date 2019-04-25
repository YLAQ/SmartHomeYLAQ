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
    
    @IBOutlet weak var username: UILabel! //用户名
    @IBOutlet weak var tel: UILabel! //手机号
    @IBOutlet weak var hp: UIImageView! //头像
    @IBOutlet weak var table: UITableView! //tableview
    var allnames:Dictionary<Int, [String]>? //cell名称
    
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
        let user = try! Realm().objects(Users.self)
        username.text = name
        for item in user {
            if name == item.name {
                tel.text = item.phone
                print(item.phone)
            }
        }
        //用户头像
        hp.image = UIImage(named: "hp")
        hp.layer.cornerRadius = 33
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        //删除当前用户
        UserDefaults.standard.setValue("", forKey: "userName")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loginpage")
        //返回Loginpage
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        table.separatorColor = UIColor.white
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
        footerView.backgroundColor = UIColor.white
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
        cell.imageView!.image = UIImage(named:"image1.png")
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        table.deselectRow(at: indexPath, animated: true)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        switch itemString {
        //家庭管理
        case "家庭管理":
            print("case0")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FamilyManagepage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //消息中心
        case "消息中心":
            print("case1")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SystemLogpage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //帮助与反馈
        case "帮助与反馈":
            print("case2")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Feedbackpage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //去评分
        case "去评分":
            print("case3")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppStorepage")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
        //设置
        case "设置":
            print("case4")
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
    
    
}

