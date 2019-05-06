//
//  CollectionViewModel.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/6.
//  Copyright © 2019 yu li. All rights reserved.
//

import Foundation
import UIKit

//右侧collectionView的数据模型（大分类下的小分类）
class CollectionViewModel: NSObject {
    
    //小分类名称
    var name : String
    //小分类图片
    var picture : String
    
    init(name: String, picture: String) {
        self.name = name
        self.picture = picture
    }
}
