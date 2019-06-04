//
//  HelpsViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/4.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class HelpsViewController: UIViewController {
    
    var id = ""
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var textView: UITextView!
    //文字大小
    let textViewFont = UIFont.systemFont(ofSize: 17)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
        
        header.font = UIFont.boldSystemFont(ofSize: 20)
        
       
        switch id {
        case "1":
            header.text = "怎么在app中添加设备？"
            insertString("1️⃣在「首页」模块中，点击「添加设备」按钮\n\n")
            insertPicture(UIImage(named: "1-1")!, mode:.fitTextView)
            insertString("\n\n2️⃣进入「添加设备」界面后，点击右上角蓝牙标识连接Arduino\n\n")
            insertPicture(UIImage(named: "1-2")!, mode:.fitTextView)
            insertString("\n\n3️⃣系统显示Arduino连接成功后，即可在列表中选择自己想要连接的设备啦\n\n")
            insertPicture(UIImage(named: "1-3")!, mode:.fitTextView)
        case "2":
            header.text = "怎么对多个设备进行群组控制？"
            insertString("1️⃣在「智能」模块中，切换至场景控制界面\n\n")
            insertPicture(UIImage(named: "2-1")!, mode:.fitTextView)
            insertString("\n\n2️⃣滑动至下方，点击「智能编排」模块，即可对多个设备进行群组控制\n\n")
            insertPicture(UIImage(named: "2-2")!, mode:.fitTextView)
        case "3":
            header.text = "如何将设备与家人共享？"
            insertString("1️⃣在「我的」模块中，点击「家庭管理」选项条\n\n")
            insertPicture(UIImage(named: "3-1")!, mode:.fitTextView)
            insertString("\n\n2️⃣在此可对家庭成员进行管理，也可向相应成员发送消息\n\n")
            insertPicture(UIImage(named: "3-2")!, mode:.fitTextView)
        case "4":
            header.text = "如何断开与Arduino的连接？"
            insertString("1️⃣在Arduino已连接的状态下，进入「首页」模块\n\n")
            insertPicture(UIImage(named: "4-1")!, mode:.fitTextView)
            insertString("2️⃣点击「添加设备」按钮\n\n")
            insertPicture(UIImage(named: "4-2")!, mode:.fitTextView)
            insertString("\n\n3️⃣点击右上角蓝牙标识，即可断开与Arduino的连接\n\n")
            insertPicture(UIImage(named: "4-3")!, mode:.fitTextView)
           
        case "5":
            header.text = "怎么查看图表？"
            insertString("1️⃣在「智能」模块中，切换至「图表统计」界面\n\n")
            insertPicture(UIImage(named: "5-1")!, mode:.fitTextView)
            insertString("2️⃣在这里您可以选择查看当前所在室内的温度、湿度与pm2.5值变化\n\n")
            insertPicture(UIImage(named: "5-2")!, mode:.fitTextView)
           insertString("\n\n")
            insertPicture(UIImage(named: "5-3")!, mode:.fitTextView)
        case "6":
            header.text = "想要修改资料应该怎么做？"
            insertString("1️⃣在「我的」模块中，点击「修改资料」按钮\n\n")
            insertPicture(UIImage(named: "6-1")!, mode:.fitTextView)
            insertString("2️⃣在「修改资料」界面，您可以选择更改用户名、手机号及密码\n\n")
            insertPicture(UIImage(named: "6-2")!, mode:.fitTextView)
        case "7":
            header.text = "如何查看消息提示？"
            insertString("1️⃣在「我的」模块中，点击「消息中心」选项\n\n")
            insertPicture(UIImage(named: "7-1")!, mode:.fitTextView)
            insertString("\n\n2️⃣在「消息中心」界面中，您可以选择查看系统告警、家庭消息及系统通知\n\n")
            insertString("3️⃣当系统监测到红外警报及烟雾警报时，会在「告警」模块中做出消息提示，可选择查看详细信息\n\n")
            insertPicture(UIImage(named: "7-2")!, mode:.fitTextView)
            insertString("\n\n4️⃣「家庭」模块显示家人发送给您的信息\n\n")
            insertPicture(UIImage(named: "7-3")!, mode:.fitTextView)
            insertString("\n\n5️⃣当系统需要更新及有要告知您的信息时，会在「通知」模块进行提示\n\n")
            insertPicture(UIImage(named: "7-4")!, mode:.fitTextView)
        case "8":
            header.text = "无法扫描到设备？"
            insertString("1️⃣连接设备前，请确保打开手机蓝牙\n\n")
            insertPicture(UIImage(named: "8-1")!, mode:.fitTextView)
            insertString("\n\n2️⃣进入「添加设备」界面后，点击右上角蓝牙标识连接Arduino\n\n")
            insertPicture(UIImage(named: "8-2")!, mode:.fitTextView)
            insertString("\n\n3️⃣系统提示无法连接Arduino时，请检查Arduino设备是否开启\n\n")
            insertPicture(UIImage(named: "1")!, mode:.fitTextView)
            
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
    
    //插入文字
    func insertString(_ text:String) {
        //获取textView的所有文本，转成可变的文本
        let mutableStr = NSMutableAttributedString(attributedString: textView.attributedText)
        //获得目前光标的位置
        let selectedRange = textView.selectedRange
        //插入文字
        let attStr = NSAttributedString(string: text)
        mutableStr.insert(attStr, at: selectedRange.location)
        
        //设置可变文本的字体属性
        mutableStr.addAttribute(NSAttributedString.Key.font, value: textViewFont,
                                range: NSMakeRange(0,mutableStr.length))
        //再次记住新的光标的位置
        let newSelectedRange = NSMakeRange(selectedRange.location + attStr.length, 0)
        
        //重新给文本赋值
        textView.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        textView.selectedRange = newSelectedRange
    }
    
    //插入图片
    func insertPicture(_ image:UIImage, mode:ImageAttachmentMode = .default){
        //获取textView的所有文本，转成可变的文本
        let mutableStr = NSMutableAttributedString(attributedString: textView.attributedText)
        
        //创建图片附件
        let imgAttachment = NSTextAttachment(data: nil, ofType: nil)
        var imgAttachmentString: NSAttributedString
        imgAttachment.image = image
        
        //设置图片显示方式
        if mode == .fitTextLine {
            //与文字一样大小
            imgAttachment.bounds = CGRect(x: 0, y: -4, width: textView.font!.lineHeight,
                                          height: textView.font!.lineHeight)
        } else if mode == .fitTextView {
            //撑满一行
            let imageWidth = textView.frame.width - 10
            let imageHeight = image.size.height/image.size.width*imageWidth
            imgAttachment.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        }
        
        imgAttachmentString = NSAttributedString(attachment: imgAttachment)
        
        //获得目前光标的位置
        let selectedRange = textView.selectedRange
        //插入文字
        mutableStr.insert(imgAttachmentString, at: selectedRange.location)
        //设置可变文本的字体属性
        mutableStr.addAttribute(NSAttributedString.Key.font, value: textViewFont,
                                range: NSMakeRange(0,mutableStr.length))
        //再次记住新的光标的位置
        let newSelectedRange = NSMakeRange(selectedRange.location+1, 0)
        
        //重新给文本赋值
        textView.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        textView.selectedRange = newSelectedRange
        //移动滚动条（确保光标在可视区域内）
//        self.textView.scrollRangeToVisible(newSelectedRange)
    }
    
    //插入的图片附件的尺寸样式
    enum ImageAttachmentMode {
        case `default`  //默认（不改变大小）
        case fitTextLine  //使尺寸适应行高
        case fitTextView  //使尺寸适应textView
    }
}
