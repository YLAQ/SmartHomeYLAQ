//
//  FamilyManageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/19.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class FamilyManageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    var count = 0
    @IBOutlet weak var table: UITableView! //tableview
    var allnames:Dictionary<Int, [String]>? //cell名称
    var adHeaders:[String]? //头部名称
    var imgs:Dictionary<Int, [String]>? //图片名称
    var detail: Dictionary<Int, [String]>? //右侧内容名称

    @IBOutlet weak var kuang: UIButton!
    
//    override func loadView() {
//        super.loadView()
//        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
        
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.imgs =  [
            0:[String]([
                "home","dizhi","chuangpu"]),
            1:[String]([
                "jiating","jiating"])
        ]
        self.allnames =  [
            0:[String]([
                "家庭名称","家庭地址","房间管理"]),
            1:[String]([
                "爸爸","妈妈"])
        ]
        self.adHeaders = [
            "基本信息",
            "家庭成员"
        ]
        
        
        //创建一个重用的单元格
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "SwiftCell")
        
        table.backgroundColor = UIColor.clear
        //分隔线
        table.separatorColor = UIColor.clear
        //cell右侧detail内容
        let name = UserDefaults.standard.object(forKey: "userName") as! String
        let realm = try! Realm()
        let user = realm.objects(Users.self)
        
        for item in user {
            if name == item.name {
                self.detail = [
                    0:[String]([
                        item.homeName,item.address,"2"]),
                    1:[String]([
                        "在线","离线"])
                ]
                
            }
        }
        
        
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
//        let cell = tableView.dequeueReusableCell( withIdentifier: identify, for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identify)
        cell.accessoryType = .disclosureIndicator
        
        let secno = indexPath.section
        var data = self.allnames?[secno]
        var img = self.imgs?[secno]
        var dtl = self.detail?[secno]
        cell.textLabel?.text = data![indexPath.row]
        //cell图片
         cell.imageView!.image = UIImage(named: img![indexPath.row])
//            cell.imageView!.image = UIImage(named:imgs[count])
//        count = count + 1
        //cell背景色
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        cell.detailTextLabel?.text = dtl![indexPath.row]
//        print(indexPath)
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        table.deselectRow(at: indexPath, animated: true)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        switch itemString {
            
        case "家庭名称":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FamilyNamepage")
            self.present(vc, animated: true, completion: nil)
            
//        case "房间管理":
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userPassChange")
//            //推出新的Controller
//            self.present(vc, animated: true, completion: nil)
            
        case "家庭地址":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Addresspage")
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
    
//    func update() {
//        //局部刷新
//        let positon = IndexPath(row: 0, section: 0)
//        table.cellForRow(at: positon)?.detailTextLabel!.text = "文字"
//        table.reloadRows(at: [positon], with: UITableView.RowAnimation.none)
//        print(positon)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func move(_ sender: Any) {
    }
}
