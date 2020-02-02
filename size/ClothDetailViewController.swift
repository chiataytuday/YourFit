//
//  ClothDetailViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/13.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift


class ClothDetailViewController: UITableViewController{
    var clothDetail: Cloth? = nil
    var clothesDetail: Clothes? = nil
    var againClothDetail: Clothes? = nil
    let realm = try? Realm() //db생성
    var clothes : Clothes?
    var mycloth : Results<Clothes>?
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var images = [UIImage]()
    @IBOutlet var clothDetailTableView: UITableView!
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
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
        if clothDetail?.url != nil{
        if let url = URL(string: clothDetail?.url ?? "http://naver.com"){
            UIApplication.shared.open(url, options: [:])
            }
            
        }
        else{
            if let url = URL(string: clothesDetail?.url ?? "http://naver.com"){
            UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
   // imageLabel.image = UIImage(named: "2001004097")

    
    
    
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
            }
        }
            
        else {
            if let exsist = realm?.objects(Clothes.self).filter("model = '\(clothesDetail!.model)'"), exsist.count != 0{
                likeButton.tintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
                clothDetail = Cloth(model: clothesDetail!.model, brand: clothesDetail!.brand, price: clothesDetail!.price, discountRate: clothesDetail!.discountRate, realPrice: clothesDetail!.realPrice, clothImage: clothesDetail!.clothImage, modelDetail: clothesDetail!.modelDetail, url: "http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no="+clothesDetail!.modelDetail, recommendSize: clothesDetail!.recommendSize)
                deleteClothData()
                //navigationController?.popViewController(animated: true)
                //Liked.shared.remove(store)
            }
            else {
                likeButton.tintColor = UIColor.red
                saveData()
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        configurePageControl()
        
       // clothDetailTableView.frame.height = 
        
//        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        if clothDetail?.clothImage != nil{
            let imageURL = clothDetail!.modelDetail + "-1"
            images = [UIImage(named: clothDetail!.clothImage)!, UIImage(named: imageURL)!]
            
        }
        else{
            let imageURL = clothesDetail!.modelDetail + "-1"
            images = [UIImage(named: clothesDetail!.clothImage)!,UIImage(named: imageURL)!]
        }
        pageControl.numberOfPages = 2
        
         
        for i in 0..<images.count{
            let imageView = UIImageView()
            let x = self.scrollView.frame.size.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: self.scrollView.frame.width-30
                , height: self.scrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            imageView.image = images[i]
            
            scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
        
        
        if clothDetail != nil{
            brandLabel.text = clothDetail?.brand
            modelLabel.text = clothDetail?.model
            //recommendSizeLabel.text = clothDetail?.recommendSize
            priceLabel.text = "가격  " + clothDetail!.price + "원"
            discountRateLabel.text = "할인  " + clothDetail!.discountRate + "%"
            realPriceLabel.text = String(clothDetail!.realPrice) + "원"
            //imageLabel.image = UIImage(named: clothDetail!.clothImage)


        }
        else if clothesDetail != nil {
            brandLabel.text = clothesDetail?.brand
            modelLabel.text = clothesDetail?.model
            //recommendSizeLabel.text = clothesDetail?.recommendSize
            priceLabel.text = "가격  " + clothesDetail!.price + "원 "
            discountRateLabel.text = "할인  " + clothesDetail!.discountRate + "%"
            realPriceLabel.text = clothesDetail!.realPrice + "원"
            //imageLabel.image = UIImage(named: clothesDetail!.clothImage)
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
        db.clothImage = clothDetail!.clothImage
        
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
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    func configurePageControl() {
           // The total number of pages that are available is based on how many available colors we have.
           self.pageControl.numberOfPages = colors.count
           self.pageControl.currentPage = 0
           self.pageControl.tintColor = UIColor.red
           self.pageControl.pageIndicatorTintColor = UIColor(red: 162/255, green: 144/255, blue: 207/255, alpha: 1)
           self.pageControl.currentPageIndicatorTintColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1)
           self.view.addSubview(pageControl)

       }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
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
