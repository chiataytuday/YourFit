//
//  LikeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/15.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift


//함수 생성해서 Result<Clothes> 이거 써야 하나 . . . . . .. ..ㅠㅠㅠㅠㅠㅠㅠㅠ

class LikeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var likeClothes : Results<Clothes>?
    //Realm에 저장된 데이터를 가져옵니다.
    let realm = try? Realm()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = likeClothes?.count {
                   return count
        } else {
             return 1
         }
       //return Liked.shared.saves.count
    }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTableViewCell", for: indexPath) as! LikeTableViewCell
        
        if let db = likeClothes?[indexPath.row]{
            cell.brandLabel.text = db.brand
            cell.modelLabel.text = db.model
            cell.priceLabel.text = db.price
            cell.recommendSizeLabel.text = db.recommendSize
        }
        
           return cell
       }
    
    @IBOutlet weak var likeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeTableView.dataSource = self
        likeTableView.delegate = self
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likeDetail" {
            if let menu = sender as? Clothes {
                let detailController = segue.destination as? ClothDetailViewController
                if detailController != nil {
                    detailController!.clothesDetail = menu
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = likeClothes?[indexPath.row]
        
        performSegue(withIdentifier: "likeDetail", sender: data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        likeClothes = realm?.objects(Clothes.self)  //.sorted(byKeyPath: "recommendSize", ascending: true)
        self.likeTableView.reloadData()
    }
}
