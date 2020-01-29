//
//  FirstEnterSizeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/29.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit

class FirstEnterSizeViewController: UIViewController {

    @IBAction func goClosetButton(_ sender: Any) {
        if let tab = self.navigationController?.tabBarController {
            tab.selectedIndex = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
