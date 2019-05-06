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
//    var getArray = [Int: String]()
//    var putArray = [Int: String]()
//    var iget = 1
//    var ipost = 1
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    private let Service_UUID: String = "FFE0"
//    private let Characteristic_UUID: String = "FFE1"
//
    @IBOutlet weak var textField: UITextField!
//
//    private var centralManager: CBCentralManager?
//    private var peripheral: CBPeripheral?
//    private var characteristic: CBCharacteristic?
    var ble = YLBlueTooth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "蓝牙中心设备"
//        ble.Service_UUID = "FFe"
        //创建中心管理器并用属性强引用，同时设置代理和选择线程
//        centralManager = CBCentralManager.init(delegate: self, queue: .main)
    }
    
    //接收框框
    @IBAction func didClickGet(_ sender: Any) {
        ble.peripheral?.readValue(for: ble.characteristic!)
    }
    
    //发送框框
    @IBAction func didClickPost(_ sender: Any) {
        let data = (self.textField.text ?? "empty input")!.data(using: String.Encoding.utf8)
        ble.peripheral?.writeValue(data!, for: ble.characteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
}
