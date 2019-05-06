//
//  CollectionViewHeader.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/6.
//  Copyright © 2019 yu li. All rights reserved.
//

import Foundation
import UIKit

//右侧collectionView的自定义分区头
class CollectionViewHeader: UICollectionReusableView {
    
    //分区头文本标签
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置分区头背景色
        backgroundColor = UIColor(r: 250, g: 250, b: 250, alpha: 0.8)
        
        //初始化分区头文本标签
        titleLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 60)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

