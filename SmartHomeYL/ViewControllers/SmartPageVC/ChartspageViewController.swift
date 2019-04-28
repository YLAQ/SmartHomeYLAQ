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
    
    @IBOutlet weak var scrollView: UIScrollView!
    //折线图
    var chartView: LineChartView!
    var chartView2: LineChartView!
    var chartView3: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //scrollView大小
        scrollView.contentSize = CGSize(width:self.view.bounds.width,height:850);
        
        let realm = try! Realm()
        //查询所有的消费记录
        let items = realm.objects(getDatas.self)
        
        
        //清空数据库
        try! realm.write {
            realm.deleteAll()
        }
        //打印出数据库地址
        print(realm.configuration.fileURL ?? "")
        //可使用数组创建
        let item1 = getDatas(value: [1,20.34,55,28,false,false,Date()])
        let item2 = getDatas(value: [2,18.25,53,27,false,false,Date()])
        let item3 = getDatas(value: [3,17.62,56,30,false,false,Date()])
        let item4 = getDatas(value: [4,17.01,62,33,true,true,Date()])
        let item5 = getDatas(value: [5,17.27,61,32,false,false,Date()])
        let item6 = getDatas(value: [6,17.03,58,35,false,false,Date()])
        let item7 = getDatas(value: [7,17.03,54,29,true,false,Date()])
        let item8 = getDatas(value: [8,18.21,54,33,false,false,Date()])
        let item9 = getDatas(value: [9,18.00,50,36,true,false,Date()])
        let item10 = getDatas(value: [10,19.00,57,31,false,false,Date()])
        
        // 数据持久化操作（类型记录也会自动添加的）
        try! realm.write {
            realm.add(item1)
            realm.add(item2)
            realm.add(item3)
            realm.add(item4)
            realm.add(item5)
            realm.add(item6)
            realm.add(item7)
            realm.add(item8)
            realm.add(item9)
            realm.add(item10)
        }
        
        
        //数据库
        var dataEntries = [ChartDataEntry]()
        var i = 0
        for item in items {
            let entry = ChartDataEntry.init(x: Double(i), y: Double(item.temprature))
            dataEntries.append(entry)
            i += 1
        }
        //温度
        //文字说明
        let bt1 = UIButton.init(type: .custom)
        scrollView.addSubview(bt1)
        bt1.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.9),for: .normal)
        bt1.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.8)
        bt1.frame = CGRect(x: 20, y: 20, width: self.view.bounds.width - 40,
                           height: 30)
        bt1.setTitle("温度变化", for: .normal)
        bt1.layer.shadowOpacity = 0.2
        bt1.layer.shadowOffset = CGSize(width: 1, height: 1)
        //背景板
        let bj1 = UIButton.init(type: .custom)
        scrollView.addSubview(bj1)
        bj1.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        bj1.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.6)
        bj1.frame = CGRect(x: 20, y: 50, width: self.view.bounds.width - 40,
                           height: 200)
        //创建折线图组件对象
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 50, width: self.view.bounds.width - 40,
                                 height: 200)
        scrollView.addSubview(chartView)
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "温度")
        //目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        chartDataSet.drawCirclesEnabled = false //不绘制转折点
        chartDataSet.mode = .horizontalBezier
        chartView.xAxis.labelPosition = .bottom
        let xValues = ["20:00","21:00","22:00","23:00","00:00","01:00","02:00","03:00","04:00","05:00"]
//        chartView.drawGridBackgroundEnabled = true
        let formatter3 = NumberFormatter()  //自定义格式
        formatter3.positiveSuffix = "°"  //数字后缀单位
        chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatter3)
        //绘制图形区域背景
        chartView.drawBordersEnabled = false  //绘制图形区域边框
        chartDataSet.lineWidth = 2 //修改线条大小
        chartDataSet.colors = [.blue] //线条颜色
        chartDataSet.valueColors = [.blue] //拐点上的文字颜色
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        chartView.xAxis.axisMinimum = 1 //最小刻度值
//        chartView.rightAxis.drawLabelsEnabled = false //不绘制右侧Y轴文字
//        chartView.leftAxis.axisMinimum = 0 //最小刻度值
//        chartView.leftAxis.axisMaximum = 50 //最大刻度值
        chartView.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
        chartView.leftAxis.zeroLineColor = .blue  //0刻度线颜色
        chartView.leftAxis.axisLineColor = .blue //左x轴颜色
        chartDataSet.highlightColor = .blue //十字线颜色
        chartDataSet.highlightLineWidth = 1 //十字线线宽
        chartDataSet.highlightLineDashLengths = [4, 2] //使用虚线样式的十字线
        //设置折现图数据
        chartView.data = chartData
        
        //湿度
        //文字说明
        let bt2 = UIButton.init(type: .custom)
        scrollView.addSubview(bt2)
        bt2.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.9),for: .normal)
        bt2.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.8)
        bt2.frame = CGRect(x: 20, y: 300, width: self.view.bounds.width - 40,
                           height: 30)
        bt2.setTitle("湿度变化", for: .normal)
        bt2.layer.shadowOpacity = 0.2
        bt2.layer.shadowOffset = CGSize(width: 1, height: 1)
        //背景板
        let bj2 = UIButton.init(type: .custom)
        scrollView.addSubview(bj2)
        bj2.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        bj2.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.6)
        bj2.frame = CGRect(x: 20, y: 330, width: self.view.bounds.width - 40,
                           height: 200)
        
        chartView2 = LineChartView()
        chartView2.frame = CGRect(x: 20, y: 330, width: self.view.bounds.width - 40,
                                 height: 200)
        scrollView.addSubview(chartView2)
        //数据库
        var dataEntries2 = [ChartDataEntry]()
        var i2 = 0
        for item in items {
            let entry = ChartDataEntry.init(x: Double(i2), y: Double(item.humidity))
            dataEntries2.append(entry)
            i2 += 1
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "湿度")
        //目前折线图只包括1根折线
        let chartData2 = LineChartData(dataSets: [chartDataSet2])
        chartDataSet2.drawCirclesEnabled = false //不绘制转折点
        chartDataSet2.mode = .horizontalBezier
        chartView2.xAxis.labelPosition = .bottom
        let xValues2 = ["20:00","21:00","22:00","23:00","00:00","01:00","02:00","03:00","04:00","05:00"]
        let formatter = NumberFormatter()  //自定义格式
        formatter.positiveSuffix = "%"  //数字后缀单位
        chartDataSet2.valueFormatter = DefaultValueFormatter(formatter: formatter)
//        chartView2.drawGridBackgroundEnabled = true  //绘制图形区域背景
        chartView2.drawBordersEnabled = false  //绘制图形区域边框
        chartDataSet2.lineWidth = 2 //修改线条大小
        chartDataSet2.colors = [.orange] //线条颜色
        chartDataSet2.valueColors = [.orange] //拐点上的文字颜色
        chartView2.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues2)
        chartView2.xAxis.axisMinimum = 1 //最小刻度值
//        chartView2.rightAxis.drawLabelsEnabled = false //不绘制右侧Y轴文字
//        chartView2.leftAxis.axisMinimum = 0 //最小刻度值
//        chartView2.leftAxis.axisMaximum = 100 //最大刻度值
        chartView2.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
        chartView2.leftAxis.zeroLineColor = .orange
        chartView2.leftAxis.axisLineColor = .orange //左x轴颜色
        chartDataSet2.highlightColor = .orange //十字线颜色
        chartDataSet2.highlightLineWidth = 1 //十字线线宽
        chartDataSet2.highlightLineDashLengths = [4, 2]
        //设置折现图数据
        chartView2.data = chartData2
        
        //pm2.5
        //文字说明
        let bt3 = UIButton.init(type: .custom)
        scrollView.addSubview(bt3)
        bt3.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.9),for: .normal)
        bt3.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.8)
        bt3.frame = CGRect(x: 20, y: 580, width: self.view.bounds.width - 40,
                           height: 30)
        bt3.setTitle("PM2.5变化", for: .normal)
        bt3.layer.shadowOpacity = 0.2
        bt3.layer.shadowOffset = CGSize(width: 1, height: 1)
        //背景板
        let bj3 = UIButton.init(type: .custom)
        scrollView.addSubview(bj3)
        bj3.setTitleColor(UIColor(red: 50/255, green: 49/255, blue: 45/255, alpha: 0.8),for: .normal)
        bj3.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 0.6)
        bj3.frame = CGRect(x: 20, y: 610, width: self.view.bounds.width - 40,
                           height: 200)
        chartView3 = LineChartView()
        chartView3.frame = CGRect(x: 20, y: 610, width: self.view.bounds.width - 40,
                                  height: 200)
        //        scrollView.backgroundColor = UIColor.yellow
        scrollView.addSubview(chartView3)
        //数据库
        var dataEntries3 = [ChartDataEntry]()
        var i3 = 0
        for item in items {
            let entry = ChartDataEntry.init(x: Double(i3), y: Double(item.pm))
            dataEntries3.append(entry)
            i3 += 1
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet3 = LineChartDataSet(values: dataEntries3, label: "PM2.5")
        //目前折线图只包括1根折线
        let chartData3 = LineChartData(dataSets: [chartDataSet3])
        chartDataSet3.drawCirclesEnabled = false //不绘制转折点
        chartDataSet3.mode = .horizontalBezier
        chartView3.xAxis.labelPosition = .bottom
        let xValues3 = ["20:00","21:00","22:00","23:00","00:00","01:00","02:00","03:00","04:00","05:00"]
        let formatter2 = NumberFormatter()  //自定义格式
        formatter2.positiveSuffix = "μg/m³"  //数字后缀单位
        chartDataSet3.valueFormatter = DefaultValueFormatter(formatter: formatter2)
        //        chartView2.drawGridBackgroundEnabled = true  //绘制图形区域背景
        chartView3.drawBordersEnabled = false  //绘制图形区域边框
        chartDataSet3.lineWidth = 2 //修改线条大小
        chartDataSet3.colors = [.darkGray] //线条颜色
        chartDataSet3.valueColors = [.darkGray] //拐点上的文字颜色
        chartView3.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues3)
        chartView3.xAxis.axisMinimum = 1 //最小刻度值
        chartView3.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
        chartView3.leftAxis.zeroLineColor = .darkGray
        chartView3.leftAxis.axisLineColor = .darkGray //左x轴颜色
        chartDataSet3.highlightColor = .darkGray //十字线颜色
        chartDataSet3.highlightLineWidth = 1 //十字线线宽
        chartDataSet3.highlightLineDashLengths = [4, 2]
        //警戒线
        let limitLine = ChartLimitLine(limit: 35, label: "优")
        limitLine.lineWidth = 1 //线宽
        limitLine.labelPosition = .leftTop //字放左边
        limitLine.valueTextColor = UIColor.red  //文字颜色
        limitLine.valueFont = UIFont.systemFont(ofSize: 10)  //文字大小
        chartView3.leftAxis.addLimitLine(limitLine)
        let limitLine2 = ChartLimitLine(limit: 75, label: "轻度污染")
        limitLine2.lineWidth = 1 //线宽
        limitLine2.labelPosition = .leftTop //字放左边
        limitLine2.valueTextColor = UIColor.red  //文字颜色
        limitLine2.valueFont = UIFont.systemFont(ofSize: 10)  //文字大小
        chartView3.leftAxis.addLimitLine(limitLine2)
        
        //设置折现图数据
        chartView3.data = chartData3
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
