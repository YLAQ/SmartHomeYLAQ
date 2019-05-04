//
//  PMViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/2.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class PMViewController: UIViewController {
    
    //折线图
    var chartView: LineChartView!
    var scrollView: UIScrollView!
    
    var token : NotificationToken? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        // 创建scrollview
        scrollView = UIScrollView(frame:CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:515))
        //scrollView大小
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.width,height:850)
        scrollView.backgroundColor = UIColor(red: 250/255, green: 246/255, blue: 237/255, alpha: 0.6)
        self.view.addSubview(scrollView)
        
        //文字说明
        let bt = UIButton.init(type: .custom)
        view.addSubview(bt)
        bt.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.9),for: .normal)
        bt.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.7)
        bt.frame = CGRect(x: 0, y: 10, width: self.view.bounds.width,
                          height: 40)
        bt.setTitle("室内PM2.5变化统计表", for: .normal)
        bt.layer.shadowOpacity = 0.1
        bt.layer.shadowOffset = CGSize(width: 1, height: 1)
        scrollView.addSubview(bt)
        //背景板
        let bj = UIButton.init(type: .custom)
        view.addSubview(bj)
        bj.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        bj.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.6)
        bj.frame = CGRect(x: 0, y: 50, width: self.view.bounds.width,
                          height: 320)
        scrollView.addSubview(bj)
        
        //数据库监听
        let realm = try! Realm()
        //查询所有记录
        let items = realm.objects(getDatas.self)
        //监听结果
        let result = realm.objects(getDatas.self)
        
        token = result.observe({ (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                //Results 现在已经填充完毕，可以不需要阻塞 UI 就可以被访问
                debugPrint("PM2.5表初始化")
                if items.count == 0 {
                    //创建折线图组件对象
                    self.chartView = LineChartView()
                    self.chartView.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width,
                                                  height: 300)
                    self.scrollView.addSubview(self.chartView)
                    //折线图无数据时显示的提示文字
                    self.chartView.noDataText = "暂无PM2.5数据"
                    self.chartView.noDataTextColor = UIColor.red
                    break
                } else {
                    debugPrint("读取已有PM2.5数据")
                    //创建折线图组件对象
                    self.chartView = LineChartView()
                    self.chartView.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width,
                                                  height: 300)
                    self.scrollView.addSubview(self.chartView)
                    //数据库
                    var dataEntries = [ChartDataEntry]()
                    //x轴时间
                    var times = [String]()
                    var i = 0
                    //向表内添加数据
                    for item in items {
                        let entry = ChartDataEntry.init(x: Double(i), y: Double(item.temprature))
                        dataEntries.append(entry)
                        times.append(item.time)
                        i += 1
                    }
                    let chartDataSet = LineChartDataSet(values: dataEntries, label: "PM2.5")
                    //目前折线图只包括1根折线
                    let chartData = LineChartData(dataSets: [chartDataSet])
                    //        chartDataSet.drawCirclesEnabled = false //不绘制转折点
                    //贝塞尔曲线
                    chartDataSet.mode = .cubicBezier
                    self.chartView.xAxis.labelPosition = .bottom
                    //x轴、y轴方向动画一起播放，持续时间都是1秒
                    self.chartView.animate(yAxisDuration: 1)
                    //x轴时间
                    let xValues = times
                    //        chartView.drawGridBackgroundEnabled = true
                    let formatterx = NumberFormatter()  //自定义格式
                    formatterx.positiveSuffix = "μg/m3"  //数字后缀单位
                    chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatterx)
                    let formattery = NumberFormatter()  //自定义格式
                    formattery.positiveSuffix = "μg/m3"  //数字后缀
                    self.chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formattery)
                    self.chartView.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formattery)
                    //绘制图形区域背景
                    self.chartView.drawBordersEnabled = false  //绘制图形区域边框
                    chartDataSet.lineWidth = 2 //修改线条大小
                    chartDataSet.colors = [UIColor(r: 205, g: 155, b: 155)] //线条颜色
                    chartDataSet.valueColors = [UIColor(r: 139, g: 105, b: 105)] //拐点上的文字颜色
                    chartDataSet.drawCircleHoleEnabled = false  //不绘制转折点内圆
                    chartDataSet.circleColors = [UIColor(r: 139, g: 105, b: 105)]  //外圆颜色
                    chartDataSet.circleRadius = 5 //外圆半径
                    self.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
                    self.chartView.xAxis.axisMinimum = 1 //最小刻度值
                    self.chartView.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
                    self.chartView.leftAxis.zeroLineColor = UIColor(r: 205, g: 155, b: 155) //0刻度线颜色
                    self.chartView.leftAxis.axisLineColor = UIColor(r: 205, g: 155, b: 155) //左x轴颜色
                    chartDataSet.highlightColor = UIColor(r: 205, g: 155, b: 155) //十字线颜色
                    chartDataSet.highlightLineWidth = 1 //十字线线宽
                    chartDataSet.highlightLineDashLengths = [4, 2] //使用虚线样式的十字线
                    //界限1
                    let limitLine1 = ChartLimitLine(limit: 35, label: "☺️")
                    limitLine1.lineWidth = 1 //线宽
                    self.chartView.leftAxis.addLimitLine(limitLine1)
                    limitLine1.lineColor = UIColor(r: 102, g: 205, b: 170) //颜色
                    limitLine1.labelPosition = .rightBottom //位置
                    limitLine1.lineDashLengths = [4, 2] //虚线样式
                    //界限2
                    let limitLine2 = ChartLimitLine(limit: 75, label: "😀")
                    limitLine2.lineWidth = 1 //线宽
                    self.chartView.leftAxis.addLimitLine(limitLine2)
                    limitLine2.lineColor = UIColor(r: 205, g: 190, b: 112) //颜色
                    limitLine2.labelPosition = .rightBottom //位置
                    limitLine2.lineDashLengths = [4, 2] //虚线样式
                    //界限3
                    let limitLine3 = ChartLimitLine(limit: 115, label: "😐")
                    limitLine3.lineWidth = 1 //线宽
                    self.chartView.leftAxis.addLimitLine(limitLine3)
                    limitLine3.lineColor = UIColor(r: 205, g: 186, b: 150) //颜色
                    limitLine3.labelPosition = .rightBottom //位置
                    limitLine3.lineDashLengths = [4, 2] //虚线样式
                    //界限4
                    let limitLine4 = ChartLimitLine(limit: 150, label: "🙁")
                    limitLine4.lineWidth = 1 //线宽
                    self.chartView.leftAxis.addLimitLine(limitLine4)
                    limitLine4.lineColor = UIColor(r: 139, g: 115, b: 85) //颜色
                    limitLine4.labelPosition = .rightBottom //位置
                    limitLine4.lineDashLengths = [4, 2] //虚线样式
                    //界限5
                    let limitLine5 = ChartLimitLine(limit: 250, label: "🙄")
                    limitLine5.lineWidth = 1 //线宽
                    self.chartView.leftAxis.addLimitLine(limitLine5)
                    limitLine5.lineColor = UIColor(r: 255, g: 69, b: 0) //颜色
                    limitLine5.labelPosition = .rightBottom //位置
                    limitLine5.lineDashLengths = [4, 2] //虚线样式
                    //设置折现图数据
                    self.chartView.data = chartData
                    break
                }
            case .update(_, deletions: _, insertions: _, modifications: _):
                //数据库发生更改（增删改）调用
                debugPrint("PM表更新")
                //数据库
                var dataEntries = [ChartDataEntry]()
                //x轴时间
                var times = [String]()
                var i = 0
                //向表内添加数据
                for item in items {
                    let entry = ChartDataEntry.init(x: Double(i), y: Double(item.temprature))
                    dataEntries.append(entry)
                    times.append(item.time)
                    i += 1
                }
                let chartDataSet = LineChartDataSet(values: dataEntries, label: "PM2.5")
                //目前折线图只包括1根折线
                let chartData = LineChartData(dataSets: [chartDataSet])
                //        chartDataSet.drawCirclesEnabled = false //不绘制转折点
                //贝塞尔曲线
                chartDataSet.mode = .cubicBezier
                self.chartView.xAxis.labelPosition = .bottom
                //x轴、y轴方向动画一起播放，持续时间都是1秒
                self.chartView.animate(yAxisDuration: 1)
                //x轴时间
                let xValues = times
                //        chartView.drawGridBackgroundEnabled = true
                let formatterx = NumberFormatter()  //自定义格式
                formatterx.positiveSuffix = "μg/m3"  //数字后缀单位
                chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatterx)
                let formattery = NumberFormatter()  //自定义格式
                formattery.positiveSuffix = "μg/m3"  //数字后缀
                self.chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formattery)
                self.chartView.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formattery)
                //绘制图形区域背景
                self.chartView.drawBordersEnabled = false  //绘制图形区域边框
                chartDataSet.lineWidth = 2 //修改线条大小
                chartDataSet.colors = [UIColor(r: 205, g: 155, b: 155)] //线条颜色
                chartDataSet.valueColors = [UIColor(r: 139, g: 105, b: 105)] //拐点上的文字颜色
                chartDataSet.drawCircleHoleEnabled = false  //不绘制转折点内圆
                chartDataSet.circleColors = [UIColor(r: 139, g: 105, b: 105)]  //外圆颜色
                chartDataSet.circleRadius = 5 //外圆半径
                self.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
                self.chartView.xAxis.axisMinimum = 1 //最小刻度值
                self.chartView.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
                self.chartView.leftAxis.zeroLineColor = UIColor(r: 205, g: 155, b: 155) //0刻度线颜色
                self.chartView.leftAxis.axisLineColor = UIColor(r: 205, g: 155, b: 155) //左x轴颜色
                chartDataSet.highlightColor = UIColor(r: 205, g: 155, b: 155) //十字线颜色
                chartDataSet.highlightLineWidth = 1 //十字线线宽
                chartDataSet.highlightLineDashLengths = [4, 2] //使用虚线样式的十字线
                //界限1
                let limitLine1 = ChartLimitLine(limit: 35, label: "☺️")
                limitLine1.lineWidth = 1 //线宽
                self.chartView.leftAxis.addLimitLine(limitLine1)
                limitLine1.lineColor = UIColor(r: 102, g: 205, b: 170) //颜色
                limitLine1.labelPosition = .rightBottom //位置
                limitLine1.lineDashLengths = [4, 2] //虚线样式
                //界限2
                let limitLine2 = ChartLimitLine(limit: 75, label: "😀")
                limitLine2.lineWidth = 1 //线宽
                self.chartView.leftAxis.addLimitLine(limitLine2)
                limitLine2.lineColor = UIColor(r: 205, g: 190, b: 112) //颜色
                limitLine2.labelPosition = .rightBottom //位置
                limitLine2.lineDashLengths = [4, 2] //虚线样式
                //界限3
                let limitLine3 = ChartLimitLine(limit: 115, label: "😐")
                limitLine3.lineWidth = 1 //线宽
                self.chartView.leftAxis.addLimitLine(limitLine3)
                limitLine3.lineColor = UIColor(r: 205, g: 186, b: 150) //颜色
                limitLine3.labelPosition = .rightBottom //位置
                limitLine3.lineDashLengths = [4, 2] //虚线样式
                //界限4
                let limitLine4 = ChartLimitLine(limit: 150, label: "🙁")
                limitLine4.lineWidth = 1 //线宽
                self.chartView.leftAxis.addLimitLine(limitLine4)
                limitLine4.lineColor = UIColor(r: 139, g: 115, b: 85) //颜色
                limitLine4.labelPosition = .rightBottom //位置
                limitLine4.lineDashLengths = [4, 2] //虚线样式
                //界限5
                let limitLine5 = ChartLimitLine(limit: 250, label: "🙄")
                limitLine5.lineWidth = 1 //线宽
                self.chartView.leftAxis.addLimitLine(limitLine5)
                limitLine5.lineColor = UIColor(r: 255, g: 69, b: 0) //颜色
                limitLine5.labelPosition = .rightBottom //位置
                limitLine5.lineDashLengths = [4, 2] //虚线样式
                //设置折现图数据
                self.chartView.data = chartData
                break
            default:
                break
            }
        })
        
        
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        
//
//    }
}
