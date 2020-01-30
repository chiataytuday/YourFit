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
    var clothesDetail: Clothes? = nil
    var againClothDetail: Clothes? = nil
    let realm = try? Realm() //db생성
    var clothes : Clothes?
    var mycloth : Results<Clothes>?

    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    //@IBOutlet weak var recommendSizeLabel: UILabel!
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
        if clothDetail != nil {
            if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothDetail!.model)'"), exsist.count != 0{
                likeButton.tintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
                deleteClothData()
                //Liked.shared.remove(store)
            }
            else {
                //Liked.shared.add(store)
                 likeButton.tintColor = UIColor.red
                saveData()
                let clothess = realm?.objects(Clothes.self)
                print(clothess)
            }
        }
        
        else {
            if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothesDetail!.model)'"), exsist.count != 0{
                likeButton.tintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
                clothDetail = Cloth(model: clothesDetail!.model, brand: clothesDetail!.brand, price: clothesDetail!.price, discountRate: clothesDetail!.discountRate, realPrice: clothesDetail!.realPrice,clothImage: #imageLiteral(resourceName: "Image"), modelDetail: clothesDetail!.modelDetail, url: "http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no="+clothesDetail!.modelDetail, recommendSize: clothesDetail!.recommendSize)
                deleteClothData()
                //navigationController?.popViewController(animated: true)
                //Liked.shared.remove(store)
            }
            else {
                //Liked.shared.add(store)
                likeButton.tintColor = UIColor.red
                saveData()
                let clothess = realm?.objects(Clothes.self)
                print(clothess)

            }
        }

        }
        
    override func viewDidLoad() {
        if clothDetail != nil {
            
            if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothDetail!.model)'"), exsist.count != 0{
                likeButton.tintColor = UIColor.red
            }
            else{
                likeButton.tintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
            }
        }
        else if clothesDetail != nil {
            if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothesDetail!.model)'"), exsist.count != 0{
                likeButton.tintColor = UIColor.red
            }
            else{
                likeButton.tintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
            }
            
            if discountRateLabel.text == "0" {
                discountRateLabel.text = ""
                realPriceLabel.text = ""
            }
            
        }


        super.viewDidLoad()
        //imageLabel?.image = clothDetail?.clothImage
        if clothDetail != nil{
            brandLabel.text = clothDetail?.brand
            modelLabel.text = clothDetail?.model
            //recommendSizeLabel.text = clothDetail?.recommendSize
            priceLabel.text = clothDetail?.price
            discountRateLabel.text = clothDetail?.discountRate
            realPriceLabel.text = clothDetail?.realPrice
        }
        else if clothesDetail != nil {
            brandLabel.text = clothesDetail?.brand
            modelLabel.text = clothesDetail?.model
            //recommendSizeLabel.text = clothesDetail?.recommendSize
            priceLabel.text = clothesDetail?.price
            discountRateLabel.text = clothesDetail?.discountRate
            realPriceLabel.text = clothesDetail?.realPrice
        }
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
            db.model = clothDetail!.model
            db.brand = clothDetail!.brand
            db.price = clothDetail!.price
            db.discountRate = clothDetail!.discountRate
            db.realPrice = clothDetail!.realPrice
            db.url = clothDetail!.url
            db.recommendSize = clothDetail!.recommendSize
            db.modelDetail = clothDetail!.modelDetail
  
        return db
    }
    func addClothData(){
        clothes = Clothes()
        clothes = inputDataToClothData(db: clothes!)
        //input Realm
        if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothes!.model)'"), exsist.count == 0 {
            try? realm?.write {
                realm?.add((clothes)!)
            }
        }
    }
    func updateClothData(){
        try? realm?.write {
            clothes = inputDataToClothData(db: clothes!)
        }
    }
    func saveData(){
        addClothData()
//        if realm?.objects(Clothes.self) == nil{
//            addClothData()
//        }else{
//            updateClothData()
//        }
        //navigationController?.popViewController(animated: true)
    }
    func deleteClothData(){
        do{
            if clothDetail != nil {
                if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothDetail!.model)'") {
                    try realm?.write {
                        realm?.delete(exsist)
                    }
                }
            }
            else if clothesDetail != nil {
                if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothesDetail!.model)'") {
                    try realm?.write {
                        realm?.delete(exsist)
                    }
                }
            }

        } catch{
            print("\(error)")
        }
    }
}

class Clothes: Object  {
    @objc dynamic var brand = ""
    @objc dynamic var model = ""
    @objc dynamic var modelDetail = ""
    @objc dynamic var price = ""
    @objc dynamic var discountRate = ""
    @objc dynamic var realPrice = ""
    @objc dynamic var clothImage = ""
    @objc dynamic var url = ""
    @objc dynamic var recommendSize = ""
    
}
