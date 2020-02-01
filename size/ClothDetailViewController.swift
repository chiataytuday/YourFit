//
//  ClothDetailViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/13.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift


class ClothDetailViewController: UITableViewController {
    var clothDetail: Cloth? = nil
    var clothesDetail: Clothes? = nil
    var againClothDetail: Clothes? = nil
    let realm = try? Realm() //db생성
    var clothes : Clothes?
    var mycloth : Results<Clothes>?
    var i = Int()
    var images: [String] = ["2001004097","2001991022"]
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    //@IBOutlet weak var recommendSizeLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var realPriceLabel: UILabel!
    @IBOutlet weak var discountRateLabel: UILabel!
    
    @IBOutlet weak var first: UIImageView!
    @IBOutlet weak var second: UIImageView!
    
    @IBAction func gotoShop(_ sender: UIButton) {
        if let url = URL(string: clothDetail?.url ?? "http://naver.com"){
            UIApplication.shared.open(url, options: [:])
        }
    }
    
   
    
    @objc func SwipeLeftImage(){
          if i<images.count-1{
              i+=1
              imageLabel.image = UIImage(named: "2001004097")
              first.image = UIImage(named: "circle")
              second.image = UIImage(named: "circle-full")
              second.isHighlighted = true
          }else{}
      }
      @objc func SwipeRightImage(){
          if i<=images.count-1 && i>0{
              i-=1
              imageLabel.image = UIImage(named: //clothDetail!.clothImage
                "1803607189"
            )
              first.image = UIImage(named: "circle-full")
              second.image = UIImage(named: "circle")
              second.isHighlighted = false
              first.isHighlighted = false
          }else{}
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
            }
        }
            
        else {
            if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothesDetail!.model)'"), exsist.count != 0{
                likeButton.tintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
                //let image = UIImage(named:"\().png")!
                clothDetail = Cloth(model: clothesDetail!.model, brand: clothesDetail!.brand, price: clothesDetail!.price, discountRate: clothesDetail!.discountRate, realPrice: clothesDetail!.realPrice, clothImage: clothesDetail!.clothImage, modelDetail: clothesDetail!.modelDetail, url: "http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no="+clothesDetail!.modelDetail, recommendSize: clothesDetail!.recommendSize)
                deleteClothData()
                //navigationController?.popViewController(animated: true)
                //Liked.shared.remove(store)
            }
            else {
                likeButton.tintColor = UIColor.red
                saveData()
                let clothess = realm?.objects(Clothes.self)
                
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        //이미지 스와이프
        
        let swipeLeftGesture=UISwipeGestureRecognizer(target: self, action: #selector(SwipeLeftImage))
           imageLabel.isUserInteractionEnabled = true
           swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
           imageLabel.addGestureRecognizer(swipeLeftGesture)
           
           let swipeRightGesture=UISwipeGestureRecognizer(target: self, action: #selector(SwipeRightImage))
           swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
           imageLabel.addGestureRecognizer(swipeRightGesture)
           
        
        
        if clothDetail != nil{
            brandLabel.text = clothDetail?.brand
            modelLabel.text = clothDetail?.model
            //recommendSizeLabel.text = clothDetail?.recommendSize
            priceLabel.text = "가격 : " + clothDetail!.price + "원"
            discountRateLabel.text = "할인율 : " + clothDetail!.discountRate + "%"
            realPriceLabel.text = "할인가 : " + String(clothDetail!.realPrice) + "원"
           

        }
        else if clothesDetail != nil {
            brandLabel.text = clothesDetail?.brand
            modelLabel.text = clothesDetail?.model
            //recommendSizeLabel.text = clothesDetail?.recommendSize
            priceLabel.text = clothesDetail?.price
            discountRateLabel.text = clothesDetail?.discountRate
            realPriceLabel.text = clothesDetail?.realPrice
            //imageLabel = clothesDetail?.clothImage
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 옵셔널
        if let cloth = clothDetail {
            modelLabel.text = cloth.model
            
        }
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
        //db.clothImage = clothDetail!.clothImage
        
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
