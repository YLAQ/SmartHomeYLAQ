//
//  AddArduino.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/4.
//  Copyright © 2019 yu li. All rights reserved.
//

//创建中心设备(CBCentralManager)
import Foundation
import CoreBluetooth
import RealmSwift
import UIKit

var ble = YLBlueTooth()

//用于看发送数据是否成功!
class YLBlueTooth:NSObject {
    //单例对象
//    internal static let instance = YLBlueTooth()
    //中心对象
    var centralManager : CBCentralManager?
    var peripheral:CBPeripheral!
    var characteristic: CBCharacteristic?
    let Service_UUID: String = "FFE0"
    let Characteristic_UUID: String = "FFE1"
    
    var bluetoothState = "" //蓝牙状态
    var connectState = false //蓝牙连接状态
    var addDevicesConnect = false
    var arduinoName = "xx"
//    var postData = ""
    
    override init() {
        super.init()
//        self.centralManager = CBCentralManager.init(delegate:self, queue:.main)
    }
}

//MARK: -- 中心管理器的代理
extension YLBlueTooth : CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func initYLble() {
        self.centralManager = CBCentralManager.init(delegate:self, queue:.main)
    }
    
    func stopYLble() {
        self.centralManager?.cancelPeripheralConnection(self.peripheral!)
        print("已断开蓝牙连接")
        self.peripheral = nil
    }
    //当创建中心管理对象的时候，会回调如下方法用来判断中心设备的蓝牙状态。当蓝牙状态没问题的时候，可以根据外设服务的UUID来扫描需要的外设。所以自然就想到了要定义与外设UUID相同的字符串
    // 判断手机蓝牙状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //界面传值
        
        switch central.state {
        case .unknown:
            print("蓝牙未知")
            bluetoothState = "蓝牙未知"
        case .resetting:
            print("蓝牙重置中")
            bluetoothState = "蓝牙重置中"
        case .unsupported:
            print("蓝牙不支持")
            bluetoothState = "蓝牙不支持"
        case .unauthorized:
            print("蓝牙未验证")
            bluetoothState = "蓝牙未验证"
        case .poweredOff:
            print("蓝牙未开启")
            bluetoothState = "蓝牙未开启"
        case .poweredOn:
            print("蓝牙已开启")
            bluetoothState = "蓝牙已开启"
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loadingpage") as! LoadingpageViewController
//            vc.bluetooth = "蓝牙可用"
//            print("蓝牙可用")
            
        central.scanForPeripherals(withServices: [CBUUID.init(string: Service_UUID)], options: nil)
        @unknown default:
            fatalError()
        }
    }
    
    //发现符合要求的外设
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheral = peripheral
        //根据外设名称来过滤
        print(peripheral.name ?? "没有找到蓝牙设备")
        if (peripheral.name?.hasPrefix(arduinoName))! {
            central.connect(peripheral, options: nil)
            print("找到外设")
        }
    }
    
    //连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //连接上之后停止扫描
        self.centralManager?.stopScan()
        //设置连接上的代理
        peripheral.delegate = self
        //根据UUID进行服务的查找
        peripheral.discoverServices([CBUUID.init(string: Service_UUID)])
        connectState = true
        print("连接成功")
    }
    
    //连接失败的回调
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接失败")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接")
        self.peripheral = nil
        connectState = false
        
        //将所有设备断开连接
        let realm = try! Realm()
        let datas = realm.objects(dataState.self)
        try! realm.write {
            datas[0].tempState = false
            datas[0].humiState = false
            datas[0].pmState = false
            datas[0].ledState = false
            datas[0].redState = false
            datas[0].lightState = false
            datas[0].fanState = false
        }
        // 重新连接
//        central.connect(peripheral, options: nil)
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
        peripheral.setNotifyValue(true, for: self.characteristic!)
        // 订阅
//        if(subscribe){
//            peripheral.setNotifyValue(true, for: self.characteristic!)
//        }
        
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
        item.redline = (arrayStrings[2] as NSString).doubleValue
//        var itempm = (arrayStrings[3] as NSString).doubleValue
        if (arrayStrings[3] as NSString).doubleValue > 0 {
            item.pm = (arrayStrings[3] as NSString).doubleValue
        } else {
            item.pm = 0
        }
//        item.pm = (arrayStrings[2] as NSString).doubleValue
        item.date = Date(timeIntervalSinceNow: 0)
        //将时间转化为string格式作为x轴时间
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm"
        item.time = dformatter.string(from: Date())
        print("item:\(item)")
        
        //当红外感应超过150，添加信息至logs表
        if item.redline > 150 {
            let log = logs()
            log.type = "红外警报"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd HH:mm"
            log.time = dformatter.string(from: item.date)
            try! realm.write {
                realm.add(log)
            }
        }
        
        //当PM值感应超过150，添加信息至logs表
        if item.pm > 250 {
            let log = logs()
            log.type = "烟雾警报"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd HH:mm"
            log.time = dformatter.string(from: item.date)
            try! realm.write {
                realm.add(log)
            }
        }
        
        try! realm.write {
            realm.add(item)
        }
        
        
        
    }
    
    func didClickPost(postData:String) {
        let data = (postData).data(using: String.Encoding.utf8)
        self.peripheral?.writeValue(data!, for: self.characteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
    /** 写入数据 */
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("写入数据")
    }

}
