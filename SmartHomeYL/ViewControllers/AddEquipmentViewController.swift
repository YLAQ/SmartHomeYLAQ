//
//  AddEquipmentViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/23.
//  Copyright © 2019 yu li. All rights reserved.
//
//返回按钮

import UIKit
import CoreBluetooth
import RealmSwift


class AddEquipmentViewController: UIViewController {
    
    //建立返回值字典
    var getArray = [Int: String]()
    var putArray = [Int: String]()
    var iget = 1
    var ipost = 1
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private let Service_UUID: String = "FFE0"
    private let Characteristic_UUID: String = "FFE1"
    
    @IBOutlet weak var textField: UITextField!
    
    private var centralManager: CBCentralManager?
    private var peripheral: CBPeripheral?
    private var characteristic: CBCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "蓝牙中心设备"
        //创建中心管理器并用属性强引用，同时设置代理和选择线程
        centralManager = CBCentralManager.init(delegate: self, queue: .main)
    }
    
    //接收框框
    @IBAction func didClickGet(_ sender: Any) {
        self.peripheral?.readValue(for: self.characteristic!)
    }
    
    //发送框框
    @IBAction func didClickPost(_ sender: Any) {
        let data = (self.textField.text ?? "empty input")!.data(using: String.Encoding.utf8)
        self.peripheral?.writeValue(data!, for: self.characteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
}


extension AddEquipmentViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
    
    //当创建中心管理对象的时候，会回调如下方法用来判断中心设备的蓝牙状态。当蓝牙状态没问题的时候，可以根据外设服务的UUID来扫描需要的外设。所以自然就想到了要定义与外设UUID相同的字符串
    // 判断手机蓝牙状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("蓝牙未知")
        case .resetting:
            print("蓝牙重置中")
        case .unsupported:
            print("蓝牙不支持")
        case .unauthorized:
            print("蓝牙未验证")
        case .poweredOff:
            print("蓝牙未启动")
        case .poweredOn:
            print("蓝牙可用")
            central.scanForPeripherals(withServices: [CBUUID.init(string: Service_UUID)],  options: nil)
        @unknown default:
            fatalError()
        }
    }
    
    //发现符合要求的外设
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheral = peripheral
        //根据外设名称来过滤
        print(peripheral.name ?? "没有找到蓝牙设备")
        if (peripheral.name?.hasPrefix("MLT-BT05"))! {
            central.connect(peripheral, options: nil)
            print("找到外设")
        }
        //        central.connect(peripheral, options: nil)
    }
    
    //连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //连接上之后停止扫描
        self.centralManager?.stopScan()
        //设置连接上的代理
        peripheral.delegate = self
        //根据UUID进行服务的查找
        peripheral.discoverServices([CBUUID.init(string: Service_UUID)])
        print("连接成功")
    }
    
    //连接失败的回调
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接失败")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接")
        // 重新连接
        central.connect(peripheral, options: nil)
    }
    
    //发现服务Servive，可以遍历服务，找到需要的服务
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service: CBService in peripheral.services! {
            print("外设中的服务有：\(service)")
        }
        //本例的外设中只有一个服务
        let service = peripheral.services?.last
        // 根据UUID寻找服务中的特征
        peripheral.discoverCharacteristics([CBUUID.init(string: Characteristic_UUID)], for: service!)
    }
    
    //发现特征Characteristic，一般开发中可以设置两个特征，一个用来发送数据，一个用来接收中心设备写过来的数据
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic: CBCharacteristic in service.characteristics! {
            print("外设中的特征有：\(characteristic)")
        }
        
        self.characteristic = service.characteristics?.last
        // 读取特征里的数据
        //        peripheral.readValue(for: self.characteristic!)
        // 订阅
        peripheral.setNotifyValue(true, for: self.characteristic!)
    }
    
    /** 订阅状态 */
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("订阅失败: \(error)")
            return
        }
        if characteristic.isNotifying {
            print("订阅成功")
        } else {
            print("取消订阅")
        }
    }
    
    /** 接收到数据 */
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        let data = characteristic.value
        let getText = String.init(data: data!, encoding: String.Encoding.utf8)
        //        self.textField.text = getText
        //字符串分割为Substring类型
        let arraySubstrings: [Substring] = getText!.split(separator: " ")
        //Substring类型转换为String类型
        let arrayStrings: [String] = arraySubstrings.compactMap { "\($0)" }
        //动作
        print("接收到数据 \(getText ?? "error in get")")

        //存入数据库
        let realm = try! Realm()
        
        let item = getDatas()
        item.humidity = (arrayStrings[0] as NSString).doubleValue
        item.temprature = (arrayStrings[1] as NSString).doubleValue
        item.date = Date(timeIntervalSinceNow: 0)
        //将时间转化为string格式作为x轴时间
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm"
        item.time = dformatter.string(from: Date())
        print("item:\(item)")
        try! realm.write {
            realm.add(item)
        }
        
        
        
    }
    
    /** 传出数据 */
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        let data = (self.textField.text ?? "empty input")!.data(using: String.Encoding.utf8)
        let postText = String.init(data: data!, encoding: String.Encoding.utf8)
        print("传出数据 \(postText ?? "error in post")")
        
        //建立字典（传来的第ipost个postDatas，其中存储的temprature）
        var postDictionary = [Int: String]()
        postDictionary[ipost] = postText
        
        //存入数据库
        let realm = try! Realm()
        
        
        for _ in postDictionary {
            let item = postDatas()
            item.id = ipost
            item.postmsg = postText!
            item.date = Date(timeIntervalSinceNow: 0)
            try! realm.write {
                realm.add(item)
            }
            print("发出的第\(ipost)个反馈是 \(item.postmsg)")
            //            打印出数据库地址
            //            print(realm.configuration.fileURL ?? "")
            ipost += 1
        }
        //        try! realm.write {
        //            realm.deleteAll()
        //        }
        //        print("postDatas数据库里现在有 \(postDatas())")
    }
    
}
