//
//  FamilyManageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/19.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class FamilyManageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var count = 0
    @IBOutlet weak var table: UITableView! //tableview
    var allnames:Dictionary<Int, [String]>? //cell名称
    var adHeaders:[String]? //头部名称
    var imgs:[String] = ["home","dizhi","chuangpu","jiating"]
    
    override func loadView() {
        super.loadView()
        //用户名、电话
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.allnames =  [
            0:[String]([
                "家庭名称","家庭地址","房间管理"]),
            1:[String]([
                "密码"])
        ];
        self.adHeaders = [
            "",
            "家庭成员"
        ]
        //创建一个重用的单元格
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "SwiftCell")
        
        //分隔线
        table.separatorColor = UIColor.white
    }
    //分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.allnames?[section]
        return data!.count
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return self.adHeaders?[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        //修改header背景颜色
        header.backgroundView?.backgroundColor = UIColor.white
        header.textLabel?.textColor = UIColor.lightGray
        //        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //        header.textLabel?.frame = header.frame
        //        header.textLabel?.textAlignment = .center
    }
    
    
    
    //  UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的尾部
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
        //cell图片
            cell.imageView!.image = UIImage(named:imgs[count])
        count = count + 1
//        }
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        table.deselectRow(at: indexPath, animated: true)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        switch itemString {
            
        case "家庭名称":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userNameChange")
            self.present(vc, animated: true, completion: nil)
            print("dian")
            
        case "房间管理":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userPassChange")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
            
        case "家庭地址":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userPhoneChange")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
            
//        case "家庭成员":
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userPhoneChange")
//            //推出新的Controller
//            self.present(vc, animated: true, completion: nil)
            
        default:
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

