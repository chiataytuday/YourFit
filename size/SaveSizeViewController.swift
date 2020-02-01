//
//  SaveSizeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/29.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift

class SaveSizeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var saveIndex:Int = 0
    
    var waistSize: String? = nil
    var thighSize: String? = nil
    var hemSize: String? = nil
    var outseamSize: String? = nil
    let usersDB = try? Realm()
    var result: String? = nil
    var sizeInformation: Results<UserSizeInformation>?
    var count = Int() {
        didSet{
            DispatchQueue.main.async {
                self.SaveSizeTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var addSizeButton: UIButton!
    @IBOutlet weak var SaveSizeTableView: UITableView!
    //@IBAction func fromVC6ToVC5 (segue : UIStoryboardSegue) {}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sizeInformation?.count == 0 {
            tableView.setEmptyView(title: "아직 옷장에 옷이 없습니다.", message: "자신의 사이즈를 추가해주세요", messageImage: #imageLiteral(resourceName: "2001991022"))
            return 0
        }
        else {
            tableView.restore()
        }
        return sizeInformation!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaveSizeTableViewCell", for: indexPath) as! SaveSizeTableViewCell
        if let db = sizeInformation?[indexPath.row]{
            cell.SaveClothIndex.text = "no." + String(indexPath.row + 1)
            cell.UserWaistSize.text = "허리 : " + db.waist + "cm"
            cell.UserThighSize.text = "허벅지 : " + db.thigh + "cm"
            cell.UserHemSize.text = "밑단 : " + db.hem + "cm"
            cell.UserOutseamSize.text = "총장 : " + db.outseam + "cm"
            //result = db.recommendSize
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do{
                print(self.sizeInformation![indexPath.row])
                if let exsist = usersDB?.objects(UserSizeInformation.self).filter("id = '\(self.sizeInformation![indexPath.row].id)'") {
                    try usersDB?.write {
                        usersDB?.delete(exsist)
                    }
                }
            } catch{
                print("\(error)")
                
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveIndex = 0
        SaveSizeTableView.dataSource = self
        SaveSizeTableView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toVC2" {
//            if let DestViewController = segue.destination as? ViewController {
//                if result != nil {
//                    DestViewController.result = Int64(result!)!
//                }
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        result = sizeInformation![indexPath.row].recommendSize
//        performSegue(withIdentifier: "toVC2", sender: self.sizeInformation![indexPath.row].recommendSize)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        sizeInformation = usersDB?.objects(UserSizeInformation.self)  //.sorted(byKeyPath: "recommendSize", ascending: true)
        self.SaveSizeTableView.reloadData()
    }
}
