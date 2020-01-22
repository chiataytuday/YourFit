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
    
    var clothes : Results<Clothes>?
    //Realm에 저장된 데이터를 가져옵니다.
    let realm = try? Realm()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = clothes?.count {
                   return count
        } else {
             return 1
         }
       //return Liked.shared.saves.count
    }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTableViewCell", for: indexPath) as! LikeTableViewCell
            //let rowData = Liked.shared.saves[indexPath.row]
        
//        cell.imageLabelll.image = realm.
//           //cell.modelLabel.text = rowData.model
//           cell.brandLabel.text = rowData.brand
//           cell.priceLabel.text = "\(rowData.price)"
//           cell.recommendSizeLabel.text = rowData.recommendSize
        
        // 안되는거 당연한거 아는데 어떻게 해야할지를 모르겠네ㅠㅠㅠㅠㅠㅠ
        //cell.modelLabel.text = db?.objects(Clothes.self)
        
        if let db = clothes?[indexPath.row]{
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
            let menu = sender as? Clothes
            if menu != nil {
                let detailController = segue.destination as? ClothDetailViewController
                if detailController != nil {
                    detailController!.clothes = menu
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = clothes?[indexPath.row]
        performSegue(withIdentifier: "likeDetail", sender: data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        clothes = realm?.objects(Clothes.self)  //.sorted(byKeyPath: "recommendSize", ascending: true)
        self.likeTableView.reloadData()
    }
}

