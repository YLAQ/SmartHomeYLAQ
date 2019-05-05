//
//  HelpsViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/5/4.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class HelpsViewController: UIViewController {
    
    var id = ""
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg3")?.cgImage
        
        switch id {
        case "1":
            //textView大小
            textView.contentSize = CGSize(width:UIScreen.main.bounds.width,height:850)
            textView.text = "首先，打开啊啊就搞回家发过去我饿过去哦温哥华"
            
        default:
            return
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //返回按钮
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
