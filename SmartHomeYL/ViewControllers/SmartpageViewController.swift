//
//  SmartpageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class SmartpageViewController: UIViewController {

    //折线图
    var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//
//        print(realm.configuration.fileURL ?? "")
//
//        //创建折线图组件对象
//        chartView = LineChartView()
//        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
//                                 height: 300)
//        self.view.addSubview(chartView)
//
//        //折线图背景色
////        chartView.backgroundColor = UIColor.yellow
//
//        //折线图无数据时显示的提示文字
//        chartView.noDataText = "暂无数据"
////        chartView.legend.form = .empty
//
//
//        //折线图描述文字和样式
//        chartView.chartDescription?.text = "所有时间"
//        chartView.chartDescription?.textColor = UIColor.red
//
//        //设置交互样式
//        chartView.scaleYEnabled = false //取消Y轴缩放
//        chartView.doubleTapToZoomEnabled = true //双击缩放
//        chartView.dragEnabled = true //启用拖动手势
//        chartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
//        chartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
//
//
//        var dataEntries = [ChartDataEntry]()
//        var i = 0
//        for item in items {
//            let entry = ChartDataEntry.init(x: Double(i), y: Double(item.temprature))
//            dataEntries.append(entry)
//            i += 1
//        }
//        //这50条数据作为1根折线里的所有数据
//        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "温度")
//        //目前折线图只包括1根折线
//        let chartData = LineChartData(dataSets: [chartDataSet])
//        chartDataSet.drawCirclesEnabled = false //不绘制转折点
//        chartDataSet.mode = .horizontalBezier
//        chartView.xAxis.labelPosition = .bottom
//        let xValues = ["10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00"]
//        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
//        chartView.xAxis.axisMinimum = 1 //最小刻度值
//        chartView.rightAxis.drawLabelsEnabled = false //不绘制右侧Y轴文字
//        chartView.leftAxis.axisMinimum = -50 //最小刻度值
//        chartView.leftAxis.axisMaximum = 50 //最大刻度值
//        chartView.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
//        chartView.leftAxis.zeroLineColor = .orange  //0刻度线颜色
//        chartView.leftAxis.zeroLineWidth = 2 //0刻度线线宽
//        chartView.leftAxis.zeroLineDashLengths = [4, 2] //0刻度线使用虚线样式
//        //设置折现图数据
//        chartView.data = chartData
    }

}
