//
//  AddExampleViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/27.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit

class AddExampleViewController: UIViewController {

    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
    }
    
    

}

