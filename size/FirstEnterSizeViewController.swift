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
        self.performSegue(withIdentifier: "toVC5", sender: "FROM VC6 TO VC5")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
