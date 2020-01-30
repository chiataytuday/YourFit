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
    @IBAction func fromVC6ToVC5 (segue : UIStoryboardSegue) {}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizeInformation!.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaveSizeTableViewCell", for: indexPath) as! SaveSizeTableViewCell
        if let db = sizeInformation?[indexPath.row]{
            cell.UserWaistSize.text = db.waist
            cell.UserThighSize.text = db.thigh
            cell.UserHemSize.text = db.hem
            cell.UserOutseamSize.text = db.outseam
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
        addSizeButton.layer.borderColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1).cgColor
        addSizeButton.layer.borderWidth = 2
        addSizeButton.layer.cornerRadius = 15
        SaveSizeTableView.dataSource = self
        SaveSizeTableView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toVC2" {
                if let DestViewController = segue.destination as? ViewController {
                    if result != nil {
                        DestViewController.result = Int64(result!)!
                    }
                }
            }
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        result = sizeInformation![indexPath.row].recommendSize
        performSegue(withIdentifier: "toVC2", sender: self.sizeInformation![indexPath.row].recommendSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sizeInformation = usersDB?.objects(UserSizeInformation.self)  //.sorted(byKeyPath: "recommendSize", ascending: true)

        
        self.SaveSizeTableView.reloadData()
    }
}
