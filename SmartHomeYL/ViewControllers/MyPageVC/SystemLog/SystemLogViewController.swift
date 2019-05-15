//
//  SystemLogViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/19.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class SystemLogViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
        /// 标题
        let titles = ["告警","家庭","通知"]
        //样式
        let style = YCTitleStyle()
        //可以滚动
        style.isScrollEnable = false
        //是否进行缩放
        style.isNeedScale = false
        style.isShowBottomLine = false
        
        // 所有的子控制器
        var childVcs = [UIViewController]()
        let vc = LogWarningViewController()
        childVcs.append(vc)
        let vc2 = LogFamilyViewController()
        childVcs.append(vc2)
        let vc3 = LogInformsViewController()
        childVcs.append(vc3)
        
        // pageView的frame
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: 603)
        // 创建YCPageView,并且添加到控制器的view中
        let pageView = YCPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style : style)
        
        view.addSubview(pageView)
        
        
    }
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    

}
