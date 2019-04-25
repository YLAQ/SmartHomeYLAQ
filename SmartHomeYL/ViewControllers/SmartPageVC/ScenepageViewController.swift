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
        scrollView.contentSize = CGSize(width:w,height:710);
        
        //banner
        let imagesURLStrings = [
            "hp.jpeg","hp2.jpeg","hp3.jpeg","hp4.jpeg","hp5.jpeg"
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
        buttonyj.setTitleColor(UIColor(red: 98/255, green: 72/255, blue: 53/255, alpha: 100),for: .normal)
        buttonyj.frame = CGRect.init(x: 0, y: 220, width: 80, height: 30)
        buttonyj.setTitle("一键执行", for: .normal)
        
        //回家
        let gohomebtn = UIButton.init(type: .custom)
        gohomebtn.frame = CGRect.init(x: 0, y: buttonyj.ll_y + 30, width: w, height: 100)
        gohomebtn.setImage(UIImage(named:"hp2"), for: .normal)
        scrollView.addSubview(gohomebtn)
//        let gohomeimg = UIImage(named: "hp2")
//        let gohomeview = UIImageView(image: gohomeimg)
//        gohomeview.frame = CGRect.init(x: 0, y: buttonyj.ll_y + 30, width: w, height: 100)
//        scrollView.addSubview(gohomeview)
        
        //离家
        let awayhomebtn = UIButton.init(type: .custom)
        awayhomebtn.frame = CGRect.init(x: 0, y: gohomebtn.ll_y + 105, width: w, height: 100)
        awayhomebtn.setImage(UIImage(named:"hp3"), for: .normal)
        scrollView.addSubview(awayhomebtn)
        
        //智能编排
        let buttonzn = UIButton.init(type: .custom)
        //将按钮添加到视图中
        scrollView.addSubview(buttonzn)
        buttonzn.setTitleColor(UIColor(red: 98/255, green: 72/255, blue: 53/255, alpha: 100),for: .normal)
        buttonzn.frame = CGRect.init(x: 0, y: awayhomebtn.ll_y + 120, width: 80, height: 30)
        buttonzn.setTitle("智能编排", for: .normal)
        
        //日落时关灯
        let sunsetbtn = UIButton.init(type: .custom)
        sunsetbtn.frame = CGRect.init(x: 0, y: buttonzn.ll_y + 30, width: w, height: 200)
        sunsetbtn.setImage(UIImage(named:"hp4"), for: .normal)
        scrollView.addSubview(sunsetbtn)

    }
}

