//
//  AddDevicesViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/6.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class AddDevicesViewController: UIViewController {
    
    
    
    //左侧tableView
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 60, width: 90,
                                 height: UIScreen.main.bounds.height)
        tableView.rowHeight = 60
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor(r: 254, g: 254, b: 254)
        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: "tableViewCell")
        return tableView
    }()
    
    //右侧collectionView的布局
    lazy var flowlayout : UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 2
        flowlayout.minimumInteritemSpacing = 2
        //分组头悬停
        flowlayout.sectionHeadersPinToVisibleBounds = true
        let itemWidth = (UIScreen.main.bounds.width - 90 - 4 - 4) / 3
        flowlayout.itemSize = CGSize(width: itemWidth,
                                     height: itemWidth + 30)
        return flowlayout
    }()
    
    //右侧collectionView
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.init(x:  90, y:  60,
                                                                 width: UIScreen.main.bounds.width - 90 ,
                                                                 height: UIScreen.main.bounds.height - 60),
                                              collectionViewLayout: self.flowlayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        //        collectionView.allowsSelection = true
        collectionView.backgroundColor = UIColor(r: 253, g: 253, b: 253,alpha: 0.7)
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.register(CollectionViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "collectionViewHeader")
        return collectionView
    }()
    
    //左侧tableView数据
    var tableViewData = [String]()
    //右侧collectionView数据
    var collectionViewData = [[CollectionViewModel]]()
    
    //右侧collectionView当前是否正在向下滚动（即true表示手指向上滑动，查看下面内容）
    var collectionViewIsScrollDown = true
    //右侧collectionView垂直偏移量
    var collectionViewLastOffsetY : CGFloat = 0.0
    
    
    //返回
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //蓝牙连接
    @IBAction func bltConnect(_ sender: Any) {
        //如果还未连接上Arduino
        //        print("asfgjawlegjklawegjl\(connect)")
        if (ble.addDevicesConnect == false) {
            //初始化蓝牙模块
            ble.initYLble()
            ble.arduinoName = "MLT-BT05"
            view.makeLoading(title: " 正在连接Arduino... ", enable: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                print(ble.connectState)
                //判断手机蓝牙状态
                if(ble.bluetoothState == "蓝牙已开启") {
                    self.view.dismissLoading()
                    //判断Arduino连接状态
                    if(ble.connectState == true){
                        //连接成功
                        print(ble.arduinoName)
                        ble.addDevicesConnect = true
                        self.view.dismissLoading()
                        self.showMsgbox(_message: "快去选择需要连接的设备吧~",_title: "Arduino连接成功(๑`▽´๑)۶")
                    } else { //连接失败
                       ble.arduinoName = "xx"
                        print(ble.arduinoName)
                        self.view.dismissLoading()
                        self.showMsgbox(_message: "请检查Arduino设备是否开启",_title: "无法连接蓝牙")
                    }
                    
                }
                    //手机蓝牙未开启
                else {
                    self.view.dismissLoading()
                    self.showMsgbox(_message: "请先打开手机蓝牙功能~",_title: "无法连接蓝牙")
                }
            }
        } else {
            //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            print("afgrqrg")
            self.showMsgboxCancle(_message: "确定要关闭与Arduino之间的蓝牙连接吗",_title: "关闭Arduino连接")
            //            }
        }
    }
    
    var states = [false,false,false,false]
    
    var titles = ["传感器","照明","家居安防","电源开关","大家电","小家电","厨房电器","运动健康","其他"]
    
    func names(i: Int) -> [String] {
        switch i {
        case 0:
            return ["温度传感器","湿度传感器","PM2.5传感器","红外传感器","门窗传感器"]
        case 1: return ["智能灯泡","床头灯","吸顶灯","LED彩色灯","台灯"]
        case 2:
            return ["智能摄像头","门锁","燃气报警器","水位报警器","CO报警器","烟雾报警器"]
        case 3:
            return ["插座","窗帘开关","场景开关","空调伴侣"]
        case 4:
            return ["空调","冰箱","洗衣机","热水器"]
        case 5:
            return ["风扇","扫地机器人","除湿器","空气净化器","取暖器","油汀","香薰机"]
        case 6:
            return ["电饭煲","烤箱","微波炉","消毒柜","热水壶"]
        case 7:
            return ["体重秤","运动手环","睡眠监测带"]
        case 8:
            return ["宠物喂食器","万能遥控器"]
        default:
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景图
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        //初始化左侧表格数据
        for item in titles {
            self.tableViewData.append(item)
        }
        
        //初始化右侧表格数据
        for i in 0...tableViewData.count {
            var models = [CollectionViewModel]()
            for item in names(i: i) {
                models.append(CollectionViewModel(name: item, picture: item))
            }
            self.collectionViewData.append(models)
        }
        
        //将tableView和collectionView添加到页面上
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        //左侧表格默认选中第一项
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true,
                            scrollPosition: .none)
        
    }
}

// tableView相关的协议方法
extension AddDevicesViewController : UITableViewDataSource, UITableViewDelegate {
    //表格分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //分区下单元格数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    //返回自定义单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell",
                                                     for: indexPath) as! TableViewCell
            cell.titleLabel.text = tableViewData[indexPath.row]
            return cell
    }
    
    //单元格选中时调用
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //右侧collection自动滚动到对应的分区
        collectionViewScrollToTop(section: indexPath.row, animated: true)
        
        //左侧tableView将该单元格滚动到顶部
        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0),
                              at: .top, animated: true)
    }
    
    //将右侧colletionView的指定分区自动滚动到最顶端
    func collectionViewScrollToTop(section: Int, animated: Bool) {
        let headerRect = collectionViewHeaderFrame(section: section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y
            - collectionView.contentInset.top)
        collectionView.setContentOffset(topOfHeader, animated: animated)
    }
    
    //后获colletionView的指定分区头的高度
    func collectionViewHeaderFrame(section: Int) -> CGRect {
        let indexPath = IndexPath(item: 0, section: section)
        let attributes = collectionView.collectionViewLayout
            .layoutAttributesForSupplementaryView(ofKind:
                UICollectionView.elementKindSectionHeader, at: indexPath)
        guard let frameForFirstCell = attributes?.frame else {
            return .zero
        }
        return frameForFirstCell;
    }
}

// collectionView相关的协议方法
extension AddDevicesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // 获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tableViewData.count
    }
    
    // 分区下单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[section].count
    }
    
    //返回自定义单元格
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "collectionViewCell", for: indexPath) as! CollectionViewCell
        let model = collectionViewData[indexPath.section][indexPath.row]
        cell.setData(model)
        return cell
    }
    
    //分区头尺寸
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:
            //右侧标题高度
            UIScreen.main.bounds.width, height: 60)
    }
    
    //返回自定义分区头
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind:
            UICollectionView.elementKindSectionHeader,
                                                                   withReuseIdentifier: "collectionViewHeader",
                                                                   for: indexPath) as! CollectionViewHeader
        view.titleLabel.text = tableViewData[indexPath.section]
        return view
    }
    
    //item对应点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //查询所有记录
        let realm = try! Realm()
        let itemstate = realm.objects(dataState.self)
        //界面跳转
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loadingpage") as! LoadingpageViewController
        switch indexPath.section {
        //第一行 传感器
        case 0:
            switch indexPath.row {
            case 0: vc.loadId = "温度传感器"
//            states[0] = false
            if(itemstate[0].tempState == false) {
                //温度状态改变
                try! realm.write {
                    itemstate[0].tempState = !itemstate[0].tempState
                }
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            } else {
                self.alreadyConnect(_message: "要断开温度传感器吗", _title: "该设备已连接", numb:0)
                }
                
            case 1: vc.loadId = "湿度传感器"
            if(itemstate[0].humiState == false) {
                //湿度状态改变
                try! realm.write {
                    itemstate[0].humiState = !itemstate[0].humiState
                }
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            } else {
                self.alreadyConnect(_message: "再看看其他设备吧~", _title: "该设备已连接", numb:1)
                }
                
            case 2: vc.loadId = "PM2.5传感器"
            if(itemstate[0].pmState == false) {
                //PM状态改变
                try! realm.write {
                    itemstate[0].pmState = !itemstate[0].pmState
                }
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            } else {
                self.alreadyConnect(_message: "再看看其他设备吧~", _title: "该设备已连接", numb:2)
                }
                
            case 3: vc.loadId = "红外传感器"
            if(itemstate[0].redState == false) {
                //红外状态改变
                try! realm.write {
                    itemstate[0].redState = !itemstate[0].redState
                }
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            } else {
                self.alreadyConnect(_message: "再看看其他设备吧~", _title: "该设备已连接", numb:3)
                }
                
            default:
                vc.loadId = "暂无"
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            }
        //第二行 照明
        case 1:
            switch indexPath.row {
            case 0: vc.loadId = "智能灯泡"
            if(itemstate[0].lightState == false) {
                //灯泡状态改变
                try! realm.write {
                    itemstate[0].lightState = !itemstate[0].lightState
                }
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            } else {
                self.alreadyConnect(_message: "再看看其他设备吧~", _title: "该设备已连接", numb:4)
                }
                
            default:
                vc.loadId = "暂无"
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            }
        //第六行 小家电
        case 5:
            switch indexPath.row {
            case 0: vc.loadId = "风扇"
            if(itemstate[0].fanState == false) {
                //风扇状态改变
                try! realm.write {
                    itemstate[0].fanState = !itemstate[0].fanState
                }
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            } else {
                self.alreadyConnect(_message: "再看看其他设备吧~", _title: "该设备已连接", numb:5)
                }
                
            default:
                vc.loadId = "暂无"
                //界面跳转
                self.present(vc, animated: true, completion: nil)
            }
            
        default:
            vc.loadId = "暂无"
            //界面跳转
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //分区头即将要显示时调用
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String, at indexPath: IndexPath) {
        //如果是由用户手动滑动屏幕造成的向上滚动，那么左侧表格自动选中该分区对应的分类
        if !collectionViewIsScrollDown
            && (collectionView.isDragging || collectionView.isDecelerating) {
            tableView.selectRow(at: IndexPath(row: indexPath.section, section: 0),
                                animated: true, scrollPosition: .top)
        }
    }
    
    //分区头即将要消失时调用
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String, at indexPath: IndexPath) {
        //如果是由用户手动滑动屏幕造成的向下滚动，那么左侧表格自动选中该分区对应的下一个分区的分类
        if collectionViewIsScrollDown
            && (collectionView.isDragging || collectionView.isDecelerating) {
            tableView.selectRow(at: IndexPath(row: indexPath.section + 1, section: 0),
                                animated: true, scrollPosition: .top)
        }
    }
    
    
    //视图滚动时触发（主要用于记录当前collectionView是向上还是向下滚动）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            collectionViewIsScrollDown = collectionViewLastOffsetY
                < scrollView.contentOffset.y
            collectionViewLastOffsetY = scrollView.contentOffset.y
        }
    }
    //设备已连接过提示
    func alreadyConnect(_message: String, _title: String,numb: Int){
        //查询所有记录
        let realm = try! Realm()
        let itemstate = realm.objects(dataState.self)
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnCancle = UIAlertAction(title: "再想想", style: .cancel, handler: nil)
        let btnOK = UIAlertAction(title: "关闭连接", style: .default, handler: {
            action in
//            self.states[numb] = true
            switch numb {
            case 0 :
                //温度状态改变
                try! realm.write {
                    itemstate[0].tempState = !itemstate[0].tempState
                }
            case 1 :
                //湿度状态改变
                try! realm.write {
                    itemstate[0].humiState = !itemstate[0].humiState
                }
            case 2 :
                //pm状态改变
                try! realm.write {
                    itemstate[0].pmState = !itemstate[0].pmState
                }
            case 3:
                //红外状态改变
                try! realm.write {
                    itemstate[0].redState = !itemstate[0].redState
                }
            case 4:
                //灯泡状态改变
                try! realm.write {
                    itemstate[0].lightState = !itemstate[0].lightState
                }
            case 5:
                //风扇状态改变
                try! realm.write {
                    itemstate[0].fanState = !itemstate[0].fanState
                }
            default:
                return
            }
            self.showMsgbox(_message: "连接已断开", _title: "操作成功")
//            print(self.states[0])
        })
        alert.addAction(btnOK)
        alert.addAction(btnCancle)
        self.present(alert, animated: true, completion: nil)
    }
    
    //提示
    func showMsgbox(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    //带取消的提示
    func showMsgboxCancle(_message: String, _title: String){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnCancle = UIAlertAction(title: "再想想", style: .cancel, handler: {
            action in
            ble.connectState = true
        })
        let btnOK = UIAlertAction(title: "关了它", style: .default, handler: {
            action in
            ble.addDevicesConnect = false
            ble.stopYLble()
            //将所有设备断开连接
//            let realm = try! Realm()
//            let datas = realm.objects(dataState.self)
//            try! realm.write {
//                datas[0].tempState = false
//                datas[0].humiState = false
//                datas[0].pmState = false
//                datas[0].ledState = false
//                datas[0].redState = false
//                datas[0].lightState = false
//                datas[0].fanState = false
//            }
            self.view.dismissLoading()
            self.showMsgbox(_message: "已断开Arduino连接",_title: "操作成功")
        })
        alert.addAction(btnOK)
        alert.addAction(btnCancle)
        self.present(alert, animated: true, completion: nil)
    }
}
