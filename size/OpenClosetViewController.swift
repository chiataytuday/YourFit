//
//  OpenClosetViewController.swift
//  size
//
//  Created by dgulinc on 2020/02/01.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift

class OpenClosetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var sizeInformation: Results<UserSizeInformation>?
    let usersDB = try? Realm()
    var result: String? = nil
    var saveIndex:Int = 0

    @IBOutlet weak var OpenClosetTableView: UITableView!
    
    var count = Int() {
        didSet{
            DispatchQueue.main.async {
                self.OpenClosetTableView.reloadData()
            }
        }
    }
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenClosetViewCell", for: indexPath) as! OpenClosetViewCell
        if let db = sizeInformation?[indexPath.row]{
            cell.openIndex.text = "no." + String(indexPath.row + 1)
            cell.openWaist.text = "허리 : " + db.waist + "cm"
            cell.openThigh.text = "허벅지 : " + db.thigh + "cm"
            cell.openHem.text = "밑단 : " + db.hem + "cm"
            cell.openOutseam.text = "총장 : " + db.outseam + "cm"
            //result = db.recommendSize
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        saveIndex = 0
        OpenClosetTableView.dataSource = self
        OpenClosetTableView.delegate = self
        // Do any additional setup after loading the view.
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
        self.OpenClosetTableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
