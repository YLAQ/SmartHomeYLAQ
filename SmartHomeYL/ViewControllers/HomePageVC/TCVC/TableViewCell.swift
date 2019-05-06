//
//  TableViewCell.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/6.
//  Copyright © 2019 yu li. All rights reserved.
//

import Foundation
import UIKit

//左侧表格的自定义单元格
class TableViewCell: UITableViewCell {
    
    //标题文本标签
    var titleLabel = UILabel()
    //左侧装饰标签
    var leftTag = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //选中样式无
        selectionStyle = .none
        //初始化标题文本标签
        titleLabel.frame = CGRect(x: 10, y: 0, width: 70, height: 60)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor(r: 74, g: 74, b: 74)
        titleLabel.highlightedTextColor = UIColor(r: 236, g: 112, b: 67)
        titleLabel.textAlignment = .center
//        titleLabel.backgroundColor = UIColor.yellow
        contentView.addSubview(titleLabel)
        
        //初始化左侧装饰标签(左边标签小块)
        leftTag.frame = CGRect(x: 0, y: 20, width: 5, height: 20)
        leftTag.backgroundColor = UIColor(r: 236, g: 112, b: 67)
        contentView.addSubview(leftTag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //在底部绘制1像素的线条
    override func draw(_ rect: CGRect) {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //线宽
        let lineWidth = 1 / UIScreen.main.scale
        //线偏移量
        let lineAdjustOffset = 1 / UIScreen.main.scale / 2
        //创建一个矩形，它的所有边都内缩固定的偏移量
        let drawingRect = self.bounds.insetBy(dx: lineAdjustOffset, dy: lineAdjustOffset)
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: self.bounds.width, y: drawingRect.maxY))
        //添加路径到图形上下文
        context.addPath(path)
        //设置笔触颜色
        context.setStrokeColor(UIColor(r: 225, g: 225, b: 225).cgColor)
        //设置笔触宽度
        context.setLineWidth(lineWidth)
        //绘制路径
        context.strokePath()
    }
    
    //设置选中样式
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? UIColor(r: 254, g: 254, b: 254)
            : UIColor(r: 246, g: 246, b: 246)
        isHighlighted = selected
        titleLabel.isHighlighted = selected
        leftTag.isHidden = !selected
    }
}

