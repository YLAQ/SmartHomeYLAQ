//
//  YCTitleStyle.swift
//  PageView-顶部标题的样式
//
//  Created by yangqianhua on2018/3/14.
//  Copyright © 2018年 yangqianhua. All rights reserved.
//

import UIKit

class YCTitleStyle {
    /// TitleView背景色
    var titleBgColor : UIColor = UIColor(r: 253, g: 253, b: 253)
    /// 是否是滚动的Titles
    var isScrollEnable : Bool = true
    /// 普通Title颜色
    var normalColor : UIColor = UIColor(r: 181, g: 181, b: 181)
    /// 选中Title颜色
    var selectedColor : UIColor = UIColor(r: 138, g: 123, b: 107)
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 16.0)
    /// 滚动Title的字体间距
    var titleMargin : CGFloat = 20
    /// 设置titleView的高度
    var titleHeight : CGFloat = 44
    
    /// 是否显示底部滚动条
    var isShowBottomLine : Bool = true
    /// 底部滚动条的颜色
    var bottomLineColor : UIColor = UIColor(r: 159, g: 142, b: 123)
    /// 底部滚动条的高度
    var bottomLineH : CGFloat = 2
    
    /// 是否进行缩放
    var isNeedScale : Bool = true
    /// 缩放比例
    var scaleRange : CGFloat = 1.2
    
    /// 是否显示遮盖
    var isShowCover : Bool = false
    /// 遮盖背景颜色
    var coverBgColor : UIColor = UIColor(r: 211, g: 211, b: 211)
    /// 遮盖背景透明度
    var coverAlpha : CGFloat = 0.6
    /// 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    /// 遮盖的高度
    var coverH : CGFloat = 25
    /// 设置圆角大小
    var coverRadius : CGFloat = 12
    
    /// 是否显示底部分割线
    var isShowSplitLine : Bool = true
    /// 底部分割线的颜色
    var splitLineColor : UIColor = UIColor(r: 211, g: 211, b: 211)
    /// 底部分割线高度
    var splitLineH : CGFloat = 0.5
}
