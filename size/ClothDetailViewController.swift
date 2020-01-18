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
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var recommendSizeLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    @IBAction func gotoShop(_ sender: UIButton) {
        if let url = URL(string: clothDetail?.url ?? "http://naver.com"){
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func onClick(_ sender: Any) {
        if let store = self.clothDetail{
            if Liked.shared.isLiked(store){
                Liked.shared.remove(store)
                //likeButton.isSelected = false
            }
            else{
                Liked.shared.add(store)
                //likeButton.isSelected = true
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLabel?.image = clothDetail?.clothImage
        brandLabel?.text = clothDetail?.brand
        modelLabel?.text = clothDetail?.model
        recommendSizeLabel?.text = clothDetail?.recommendSize
        priceLabel?.text = "\(clothDetail?.price)"
    }


    override func viewWillAppear(_ animated: Bool) {
        // 옵셔널
        if let cloth = clothDetail {
            modelLabel.text = cloth.model
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
