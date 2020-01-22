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
        return clothes?.count
        if let count = clothes?.count {
                   return count
        }else {
             return 1
         }
       return Liked.shared.saves.count
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
        }
        
           return cell
       }
    
    @IBOutlet weak var likeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeTableView.dataSource = self
        likeTableView.delegate = self
        //addPersonData()
        
    }
    

        
//        do {
//
//        if db != nil{
//            try? db?.write { //모든 쓰기 작업은 이곳에서 / 실 시 간 업 데 이 트 가 됨.
//                var clothes = Clothes()
//                clothes = inputDataToPersionData(db: clothes)
//                db?.add(clothes) // dogToAdd 에 담긴 정보가 db에 저장됨
//            }
//            //읽기
//            let dogs = db?.objects(Clothes.self)
//            print(dogs)
//
//            }} catch {
//            print(error)
//        }
//
    
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

        self.likeTableView.reloadData()
    }
}

//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        do {
//        let db = try? Realm() //db생성
//        if db != nil{
//
//            try? db?.write { //모든 쓰기 작업은 이곳에서 / 실 시 간 업 데 이 트 가 됨.
//                let dogToAdd = Dog()
//
//                dogToAdd.name = "Fido"
//                db?.add(dogToAdd) // dogToAdd 에 담긴 정보가 db에 저장됨
//            }
//            //읽기
//            let dogs = db?.objects(Dog.self)
//            print(dogs)
//
//            }} catch {
//            print(error)
//        }
//
//    }
//
//}
////

