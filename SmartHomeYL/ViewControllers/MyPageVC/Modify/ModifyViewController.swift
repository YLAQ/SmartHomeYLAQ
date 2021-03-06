//
//  ModifyViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/23.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var navi: UINavigationBar!
    @IBOutlet weak var table: UITableView! //tableview
    var allnames:Dictionary<Int, [String]>? //cell名称
     var adHeaders:[String]? //头部名称
    //cell图片
    var count = 0
    var imgs:[String] = ["user-boy","phone","mima"]
    
    override func loadView() {
        super.loadView()
        //用户名、电话
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //图片不变形
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
//        navi.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.allnames =  [
            0:[String]([
                "用户名","手机号"]),
            1:[String]([
                "密码"])
        ];
        self.adHeaders = [
            "基本资料",
            "密码修改"
        ]
        //创建一个重用的单元格
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "SwiftCell")

        table.backgroundColor = UIColor.clear
        //分隔线
        table.separatorColor = UIColor.clear
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
        header.backgroundView?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
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
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        table.deselectRow(at: indexPath, animated: true)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        switch itemString {
        
        case "用户名":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userNameChange")
            self.present(vc, animated: true, completion: nil)
            
        case "密码":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userPassChange")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
            
        case "手机号":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userPhoneChange")
            //推出新的Controller
            self.present(vc, animated: true, completion: nil)
            
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
