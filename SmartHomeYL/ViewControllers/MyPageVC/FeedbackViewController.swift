//
//  FeedbackViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/23.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: UIViewController, UITableViewDataSource, UITableViewDelegate ,MFMailComposeViewControllerDelegate {
    
    var count = 0
    @IBOutlet weak var table: UITableView! //tableview
    var allnames:Dictionary<Int, [String]>? //cell名称
    var adHeaders:[String]? //头部名称
    var imgs:[String] = ["wenti","wenti","wenti","wenti","wenti","wenti","wenti","wenti","fankui"]
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.allnames =  [
            0:[String]([
                "怎么在app中添加设备？","怎么对多个设备进行群组控制？","如何将设备与家人共享？","如何断开与Arduino的连接？","怎么查看图表？","想要修改资料应该怎么做？","如何查看消息提示？","无法扫描到设备？"]),
            1:[String]([
                "添加反馈"])
        ];
        self.adHeaders = [
            "常见问题",
            "反馈"
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
        //cell背景色
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        table.deselectRow(at: indexPath, animated: true)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        switch itemString {
            
        case "怎么在app中添加设备？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "1"
            self.present(vc, animated: true, completion: nil)
        
        case "怎么对多个设备进行群组控制？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "2"
            self.present(vc, animated: true, completion: nil)
            
        case "如何将设备与家人共享？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "3"
            self.present(vc, animated: true, completion: nil)
            
        case "如何断开与Arduino的连接？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "4"
            self.present(vc, animated: true, completion: nil)
            
        case "怎么查看图表？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "5"
            self.present(vc, animated: true, completion: nil)
            
        case "想要修改资料应该怎么做？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "6"
            self.present(vc, animated: true, completion: nil)
            
        case "如何查看消息提示？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "7"
            self.present(vc, animated: true, completion: nil)
            
        case "无法扫描到设备？":
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Helpspage") as! HelpsViewController
            //界面传值
            vc.id = "8"
            self.present(vc, animated: true, completion: nil)
            
        case "添加反馈":
            sentMail()
            
            
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
    
    //发送邮件部分
    func sentMail() {
        //0.首先判断设备是否能发送邮件
        if MFMailComposeViewController.canSendMail() {
            //1.配置邮件窗口
            let mailView = configuredMailComposeViewController()
            //2. 显示邮件窗口
            present(mailView, animated: true, completion: nil)
        } else {
            print("哎呀...设备不能发送邮件")
            showSendMailErrorAlert()
        }
    }
    
    
    //MARK:- helper methods
    //配置邮件窗口
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        //设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["864410187@qq.com"])
        mailComposeVC.setSubject("YL智能家居app使用反馈")
//        mailComposeVC.setMessageBody("请在此输入您的反馈~", isHTML: true)
        mailComposeVC.setMessageBody("\n\n\n\n系统版本：\(systemVersion)\n设备型号：\(modelName)", isHTML: false)
        
        return mailComposeVC
    }
    //提示框，提示用户设置邮箱
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "未开启邮件功能", message: "设备邮件功能尚未开启，请在设置中更改", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
    }
    
    
    //MARK:- Mail Delegate
    //用户退出邮件窗口时被调用
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue{
        case MFMailComposeResult.sent.rawValue:
            
            print("邮件已发送")
        case MFMailComposeResult.cancelled.rawValue:
            print("邮件已取消")
        case MFMailComposeResult.saved.rawValue:
            print("邮件已保存")
        case MFMailComposeResult.failed.rawValue:
            print("邮件发送失败")
        default:
            print("邮件没有发送")
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    //获取设备名称
    let deviceName = UIDevice.current.name
    //获取系统版本号
    let systemVersion = UIDevice.current.systemVersion
    //获取设备的型号
    let deviceModel = UIDevice.current.model
    //获取设备唯一标识符
    let deviceUUID = UIDevice.current.identifierForVendor?.uuidString
    //调用
    let modelName = UIDevice.current.modelName
    //设备信息
    let infoDic = Bundle.main.infoDictionary
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1": return "iPod Touch 5"
        case "iPod7,1": return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
            case "iPhone9,1": return "iPhone 7"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1", "iPad5,2": return "iPad Mini 4"
        case "iPad6,7", "iPad6,8": return "iPad Pro"
        case "AppleTV5,3": return "Apple TV"
        case "i386", "x86_64": return "Simulator"
        default: return identifier
        }
    }
}

