//
//  SmartpageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class SmartpageViewController: UIViewController {
    
    let NavH:CGFloat = UIScreen.main.bounds.height == 812 ? 84 : 64
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        
        let topview = UIView(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:20))
        topview.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        self.view.addSubview(topview)
        /// 标题
        let titles = ["场景控制","图表统计"]
        //样式
        let style = YCTitleStyle()
        //可以滚动
        style.isScrollEnable = false
        
        // 所有的子控制器
        var childVcs = [UIViewController]()
        let vc = ScenepageViewController()
        childVcs.append(vc)
        let vc2 = ChartspageViewController()
        childVcs.append(vc2)
        
        // pageView的frame
        let pageFrame = CGRect(x: 0, y: 20, width: view.bounds.width, height: 648)
        // 创建YCPageView,并且添加到控制器的view中
        let pageView = YCPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style : style)
//        pageView.backgroundColor = UIColor.red
        view.addSubview(pageView)
        
    }

}
