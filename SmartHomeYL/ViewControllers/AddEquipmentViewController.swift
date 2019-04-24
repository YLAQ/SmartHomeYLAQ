//
//  AddEquipmentViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/23.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class AddEquipmentViewController: UIViewController {

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
    let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //同时添加多个按钮
        self.navigationItem.rightBarButtonItems = [addButton,cameraButton,editButton]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
