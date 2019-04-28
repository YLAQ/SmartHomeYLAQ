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

    @IBOutlet weak var zn: UIButton!
    @IBOutlet weak var tb: UIButton!
    
    @IBAction func zn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Scenepage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func tb(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chartspage")
        //推出新的Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "bg4")?.cgImage
        
        zn.layer.cornerRadius = 10
        zn.layer.shadowOpacity = 0.2
        zn.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        tb.layer.cornerRadius = 10
        tb.layer.shadowOpacity = 0.2
        tb.layer.shadowOffset = CGSize(width: 1, height: 1)
    }

}
