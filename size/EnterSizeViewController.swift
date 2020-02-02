//
//  EnterSizeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/20.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift

class EnterSizeViewController: UIViewController {
    let usersDB = try? Realm()
    var userSize : UserSizeInformation?
    var count = 0
    
    private let model = SizeTabularClassifier()
    
    @IBOutlet weak var waistValue: UITextField!
    @IBOutlet weak var thighValue: UITextField!
    @IBOutlet weak var hemValue: UITextField!
    @IBOutlet weak var outseamValue: UITextField!
    @IBOutlet weak var probability: UILabel!
    @IBOutlet weak var sizeCheckButton: UIButton!
    @IBOutlet weak var sizeSearchButton: UIButton!
    @IBOutlet weak var goClosetButtonOutlet: UIButton!
    @IBAction func goClosetButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toVC5", sender: "FROM VC6 TO VC5")
    }
    
    var data:[Float] = [0,0,0,0]
    var result = Int64()
    
    @IBAction func searchClothButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toVC1", sender: "FROM VC3 TO VC1")
    }
    @IBAction func runPredict(_ sender: Any) {
        if let waist = Double(waistValue.text ?? ""),
            let thigh = Double(thighValue.text ?? ""),
            let hem = Double(hemValue.text ?? ""),
            let outseam = Double(outseamValue.text ?? "") {
            if let prediction = try? model.prediction(waist: waist, thigh: thigh, hem: hem, outseam: outseam) {
                result = prediction.size
                
                if let high = prediction.sizeProbability[prediction.size] {
                    probability.text = "사용자의 추천 사이즈는 \(Int(high*100))% 확률로 \(prediction.size) 입니다."
                }
            }
            addUserData(waist: String(waist), thigh: String(thigh), hem: String(hem), outseam: String(outseam), recommendSize: String(result))
        }
        count += 1
        sizeSearchButton.alpha  = 1;
        goClosetButtonOutlet.alpha = 1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sizeCheckButton.layer.borderColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1).cgColor
        sizeCheckButton.layer.borderWidth = 2
        sizeCheckButton.layer.cornerRadius = 2
        sizeSearchButton.layer.borderColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1).cgColor
        sizeSearchButton.layer.borderWidth = 2
        sizeSearchButton.layer.cornerRadius = 2
        sizeSearchButton.alpha  = 0;
        goClosetButtonOutlet.layer.borderColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1).cgColor
        goClosetButtonOutlet.layer.borderWidth = 2
        goClosetButtonOutlet.layer.cornerRadius = 2
        goClosetButtonOutlet.alpha = 0;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        waistValue.text = String(data[0])
        thighValue.text = String(data[1])
        hemValue.text = String(data[2])
        outseamValue.text = String(data[3])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let DestViewController: ViewController = segue.destination as! ViewController
        //        DestViewController.waistSize = waistValue.text!
        //        DestViewController.thighSize = thighValue.text!
        //        DestViewController.hemSize = hemValue.text!
        //        DestViewController.outseamSize = outseamValue.text!
        //        DestViewController.result = result
        if segue.identifier == "toVC1" {
            if let DestViewController = segue.destination as? ViewController {
                DestViewController.result = result
            }
        }
        if segue.identifier == "toVC5" {
            if let DestViewController = segue.destination as? SaveSizeViewController {
                DestViewController.count = count
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func inputSizeToUserSizeData (db : UserSizeInformation, waist: String, thigh: String, hem: String, outseam: String, recommendSize: String) -> UserSizeInformation {
        
        //Liked.share.saves에 있는 데이터 다 가져와서 . . . .넣고 싶은데... ㅠㅠㅠㅠㅠㅠㅠ
        db.waist = waist
        db.thigh = thigh
        db.hem = hem
        db.outseam = outseam
        db.recommendSize = recommendSize
        return db
    }
    
    func addUserData(waist: String, thigh: String, hem: String, outseam: String, recommendSize: String){
        userSize = UserSizeInformation()
        userSize = inputSizeToUserSizeData(db: userSize!, waist: waist, thigh: thigh, hem: hem, outseam: outseam, recommendSize: recommendSize)
        //input Realm
        do{
            try usersDB?.write {
                if userSize != nil {
                    usersDB?.add(userSize!)
                }
            }
        } catch {
            print(error)
        }
    }
}

class UserSizeInformation: Object  {
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var waist = ""
    @objc dynamic var thigh = ""
    @objc dynamic var hem = ""
    @objc dynamic var outseam = ""
    @objc dynamic var recommendSize = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}


//편집... 사이즈 이름 짜기. .
