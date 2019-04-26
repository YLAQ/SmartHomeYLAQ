//
//  SmartpageViewController.swift
//  SmartHomeYL
//
//  Created by hua li on 2019/4/14.
//  Copyright © 2019 yu li. All rights reserved.
//

import UIKit
import RealmSwift

class SmartpageViewController: UIViewController {

    @IBAction func left(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Scenepage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func right(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chartspage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
