//
//  ClothDetailViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/13.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit

class ClothDetailViewController: UIViewController {
    var clothDetail: Cloth? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.clothDetail?.model)
    }

}
