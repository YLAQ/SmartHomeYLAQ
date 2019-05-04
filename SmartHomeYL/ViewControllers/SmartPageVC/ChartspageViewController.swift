//
//  ChartspageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/25.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ChartspageViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        
        /// 标题
        let titles = ["温度","湿度","PM2.5"]
        //样式
        let style = YCTitleStyle()
        //可以滚动
        style.isScrollEnable = false
        //是否进行缩放
        style.isNeedScale = false
        style.isShowBottomLine = false
        
        // 所有的子控制器
        var childVcs = [UIViewController]()
        let vc = TempratureViewController()
        childVcs.append(vc)
        let vc2 = HumidityViewController()
        childVcs.append(vc2)
        let vc3 = PMViewController()
        childVcs.append(vc3)
        
        // pageView的frame
        let pageFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 555)
        // 创建YCPageView,并且添加到控制器的view中
        let pageView = YCPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style : style)
        
        view.addSubview(pageView)
        
//        let realm = try! Realm()
//
//        try! realm.write {
//            realm.deleteAll()
//        }
//        //打印出数据库地址
//        print(realm.configuration.fileURL ?? "")
//        //可使用数组创建
//        let item1 = getDatas(value: [22,51,30,"1:00",Date()])
//        let item2 = getDatas(value: [24,21,40,"2:00",Date()])
//        let item3 = getDatas(value: [42,51,11,"3:00",Date()])
//        let item4 = getDatas(value: [12,71,20,"4:00",Date()])
//        let item5 = getDatas(value: [52,81,30,"5:00",Date()])
//        let item6 = getDatas(value: [22,41,1,"6:00",Date()])
//        let item7 = getDatas(value: [26,41,69,"7:00",Date()])
//        let item8 = getDatas(value: [20,61,50,"8:00",Date()])
//
//        // 数据持久化操作（类型记录也会自动添加的）
//        try! realm.write {
//            realm.add(item1)
//            realm.add(item2)
//            realm.add(item3)
//            realm.add(item4)
//            realm.add(item5)
//            realm.add(item6)
//            realm.add(item7)
//            realm.add(item8)
//        }
        
        
        
    }
    
}
