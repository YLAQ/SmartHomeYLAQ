//
//  ScenepageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/25.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import LLCycleScrollView

class ScenepageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //屏幕宽度
        let w = UIScreen.main.bounds.width
        
        //scrollView大小
        scrollView.contentSize = CGSize(width:w,height:810);
        
        //banner
        let imagesURLStrings = [
            "bn1","bn2","bn3","bn4","bn5"
        ];
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
        banner.customPageControlInActiveTintColor = UIColor.lightGray
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
        
        let gohomebtn = UIButton.init(type: .custom)
        gohomebtn.frame = CGRect.init(x: 0, y: buttonyj.ll_y + 30, width: w, height: 150)
        gohomebtn.setImage(UIImage(named:"sunrise"), for: .normal)
        scrollView.addSubview(gohomebtn)
        
        //文字说明
        let buttonrc = UIButton.init(type: .custom)
        scrollView.addSubview(buttonrc)
        buttonrc.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonrc.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.3)
        buttonrc.frame = CGRect.init(x: 0, y: gohomebtn.ll_y + 120, width: w , height: 30)
        buttonrc.setTitle("日出时关灯", for: .normal)
        
        //天黑开灯
        let awayhomebtn = UIButton.init(type: .custom)
        awayhomebtn.frame = CGRect.init(x: 0, y: gohomebtn.ll_y + 155, width: w, height: 150)
        awayhomebtn.setImage(UIImage(named:"night"), for: .normal)
        scrollView.addSubview(awayhomebtn)
        //文字说明
        let buttonrl = UIButton.init(type: .custom)
        scrollView.addSubview(buttonrl)
        buttonrl.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonrl.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.3)
        buttonrl.frame = CGRect.init(x: 0, y: awayhomebtn.ll_y + 120, width: w , height: 30)
        buttonrl.setTitle("天黑时开灯", for: .normal)
        
        //智能编排
        let buttonzn = UIButton.init(type: .custom)
        //将按钮添加到视图中
        scrollView.addSubview(buttonzn)
       buttonzn.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonzn.frame = CGRect.init(x: 0, y: awayhomebtn.ll_y + 170, width: 80, height: 30)
        buttonzn.setTitle("智能编排", for: .normal)
        
        //日落时关灯
        let sunsetbtn = UIButton.init(type: .custom)
        sunsetbtn.frame = CGRect.init(x: 0, y: buttonzn.ll_y + 30, width: w, height: 200)
        sunsetbtn.setImage(UIImage(named:"diy"), for: .normal)
        scrollView.addSubview(sunsetbtn)
        //文字说明
        let buttonsun = UIButton.init(type: .custom)
        scrollView.addSubview(buttonsun)
        buttonsun.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        buttonsun.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.7)
        buttonsun.frame = CGRect.init(x: 0, y: sunsetbtn.ll_y + 170, width: w , height: 30)
        buttonsun.setTitle("定制属于您自己的智能编排", for: .normal)

    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

