//
//  ChartspageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/25.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import LLCycleScrollView
class ChartspageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let w = UIScreen.main.bounds.width
        // 网络图，本地图混合
        let imagesURLStrings = [
            "s3.jpg",
            "http://www.g-photography.net/file_picture/3/3587/4.jpg",
            "http://img2.zjolcdn.com/pic/0/13/66/56/13665652_914292.jpg",
            "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
            "http://img3.redocn.com/tupian/20150806/weimeisheyingtupian_4779232.jpg",
        ];
        
    let bannerDemo1 = LLCycleScrollView.llCycleScrollViewWithArrow(CGRect.init(x:  0, y: 0, width: w, height: 200), arrowLRImages: [UIImage.init(named: "zuojiantou")!, UIImage.init(named: "youjiantou")!], imageURLPaths: imagesURLStrings, titles:nil, didSelectItemAtIndex: { index in
        print("当前点击图片的位置为:\(index)")
    })
    
    bannerDemo1.lldidSelectItemAtIndex = { index in
    
    }
    bannerDemo1.customPageControlStyle = .snake
    bannerDemo1.customPageControlInActiveTintColor = UIColor.gray
    bannerDemo1.pageControlPosition = .center
    bannerDemo1.pageControlLeadingOrTrialingContact = 28
    scrollView.addSubview(bannerDemo1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
