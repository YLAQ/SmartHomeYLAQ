//
//  DesignItemsViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/26.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class DesignItemsViewController: UIViewController {
    
    @IBOutlet weak var bianji: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageblac: UIView!
    @IBOutlet weak var name: UIButton!
    var passname = ""
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var znbptj: UIImageView!
    @IBOutlet weak var znbpadd: UIImageView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var znbpadd2: UIImageView!
    @IBOutlet weak var znbptj2: UIImageView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
        bianji.image = UIImage(named: "bianji")
        image.image = UIImage(named: "znbpimg")
        image.layer.cornerRadius = 10
        imageblac.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        znbpadd.image = UIImage(named: "znbpadd")
        znbptj.image = UIImage(named: "znbptj")
        znbpadd2.image = UIImage(named: "znbpadd")
        znbptj2.image = UIImage(named: "znbptj")
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        view3.layer.cornerRadius = 10
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func name(_ sender: Any) {
        var inputText:UITextField = UITextField()
        let msgAlertCtr = UIAlertController.init(title: "编辑名称", message: "", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style:.default) { (action:UIAlertAction) ->() in
            if((inputText.text) == ""){
                print("你输入的是：\(String(describing: inputText.text))")
            } else {
                self.name.setTitle(inputText.text, for: .normal)
                self.passname = inputText.text!
            }
        }
        let cancel = UIAlertAction.init(title: "取消", style:.cancel) { (action:UIAlertAction) -> ()in
            print("取消输入")
        }
        msgAlertCtr.addAction(ok)
        msgAlertCtr.addAction(cancel)
        msgAlertCtr.addTextField { (textField) in
            inputText = textField
            inputText.placeholder = "请输入场景名称"
        }
        self.present(msgAlertCtr, animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
}
