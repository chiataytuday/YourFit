//
//  ClothDetailViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/13.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift

class ClothDetailViewController: UIViewController {
    var clothDetail: Cloth? = nil
    let db = try? Realm() //db생성
    var clothes : Clothes?
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var recommendSizeLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var realPriceLabel: UILabel!
    @IBOutlet weak var discountRateLabel: UILabel!
    
    
    @IBAction func gotoShop(_ sender: UIButton) {
        if let url = URL(string: clothDetail?.url ?? "http://naver.com"){
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func onClick(_ sender: Any) {
        if let store = self.clothDetail{
            if Liked.shared.isLiked(store){
                Liked.shared.remove(store)
                likeButton.tintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
                do{
                    try self.db?.write{
                        self.db?.delete(self.clothes!)
                    }
                } catch{
                    print("\(error)")
                }
                
                
            }
            else{
                Liked.shared.add(store)
                 likeButton.tintColor = UIColor.red
                saveData()
                let clothess = db?.objects(Clothes.self)
                print(clothess)
                
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLabel?.image = clothDetail?.clothImage
        brandLabel.text = clothDetail?.brand
        modelLabel.text = clothDetail?.model
        recommendSizeLabel.text = clothDetail?.recommendSize
        priceLabel.text = clothDetail?.price
        discountRateLabel.text = clothDetail?.discountRate
        realPriceLabel.text = clothDetail?.realPrice
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
    func inputDataToClothData (db : Clothes) -> Clothes {
        
        //Liked.share.saves에 있는 데이터 다 가져와서 . . . .넣고 싶은데... ㅠㅠㅠㅠㅠㅠㅠ
        
        db.model = Liked.shared.saves[0].model
        db.brand = Liked.shared.saves[0].brand
        return db
    }
    func addClothData(){
        var clothes = Clothes()
        clothes = inputDataToClothData(db: clothes)
        //input Realm
        try? db?.write {
            db?.add(clothes)
        }
//        let cloth = db?.objects(Clothes.self)
//                    print(cloth)
    }
    func updateClothData(){
        try? db?.write {
            clothes = inputDataToClothData(db: clothes!)
        }
    }
    func saveData(){
        if clothes == nil{
            addClothData()
        }else{
            updateClothData()
        }
        
        navigationController?.popViewController(animated: true)
    }
}

class Clothes: Object  {
    @objc dynamic var brand = ""
    @objc dynamic var model = ""
    @objc dynamic var price = ""
    @objc dynamic var discountRate = ""
    @objc dynamic var realPrice = ""
    //@objc dynamic var clothImage =
    @objc dynamic var url = ""
    @objc dynamic var recommendSize = ""

}

