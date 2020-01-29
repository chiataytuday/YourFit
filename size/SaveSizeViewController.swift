//
//  SaveSizeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/29.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift

class SaveSizeViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var waistSize: String? = nil
    var thighSize: String? = nil
    var hemSize: String? = nil
    var outseamSize: String? = nil
    var SizeInformation: Results<UserSizeInformation>?
    let usersDB = try? Realm()


    //var sizeInformation = ClothLengthInformation(waist: waistSize, thigh: thighSize, hem: hemSize, outseam: outseamSize)
    
    @IBOutlet weak var SaveSizeTableView: UITableView!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = SizeInformation?.count {
                   return count
        } else {
             return 1
         }
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaveSizeTableViewCell", for: indexPath) as! SaveSizeTableViewCell
        if let db = SizeInformation?[indexPath.row]{
            cell.UserWaistSize.text = db.waist
            cell.UserThighSize.text = db.thigh
            cell.UserHemSize.text = db.hem
            cell.UserOutseamSize.text = db.outseam
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveSizeTableView.dataSource = self
        SaveSizeTableView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        SizeInformation = usersDB?.objects(UserSizeInformation.self)  //.sorted(byKeyPath: "recommendSize", ascending: true)
        self.SaveSizeTableView.reloadData()
    }
}


//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Uncomment the following line to preserve selection between presentations
//    self.clearsSelectionOnViewWillAppear = false
//
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem
//}
//
//// MARK: - Table view data source
//
//override func numberOfSections(in tableView: UITableView) -> Int {
//    // #warning Incomplete implementation, return the number of sections
//    return 0
//}
//
//override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // #warning Incomplete implementation, return the number of rows
//    return 0
//}
//
//
//override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//    // Configure the cell...
//
//    return cell
//}
//
//
//
//// Override to support conditional editing of the table view.
//override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//    // Return false if you do not want the specified item to be editable.
//    return true
//}
//
//
//
//// Override to support editing the table view.
//override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//        // Delete the row from the data source
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    } else if editingStyle == .insert {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
//
//
//
//// Override to support rearranging the table view.
//override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//}
//
//
//
//// Override to support conditional rearranging of the table view.
//override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//    // Return false if you do not want the item to be re-orderable.
//    return true
//}
//
//
//
//// MARK: - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    // Get the new view controller using segue.destination.
//    // Pass the selected object to the new view controller.
//}


