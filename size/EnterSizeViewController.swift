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


    private let model = SizeTabularClassifier()

    @IBOutlet weak var waistValue: UITextField!
    @IBOutlet weak var thighValue: UITextField!
    @IBOutlet weak var hemValue: UITextField!
    @IBOutlet weak var outseamValue: UITextField!
    @IBOutlet weak var probability: UILabel!
    @IBOutlet weak var sizeCheckButton: UIButton!
    @IBOutlet weak var sizeSearchButton: UIButton!
    
    var data:[Float] = []
    var result = Int64()
    
    @IBAction func runPredict(_ sender: Any) {
        if let waist = Double(waistValue.text ?? ""),
            let thigh = Double(thighValue.text ?? ""),
            let hem = Double(hemValue.text ?? ""),
            let outseam = Double(outseamValue.text ?? "") {
            if let prediction = try? model.prediction(waist: waist, thigh: thigh, hem: hem, outseam: outseam) {
                print(prediction.sizeProbability)
                result = prediction.size
                print(result)

                if let high = prediction.sizeProbability[prediction.size] {
                    probability.text = "사용자의 추천 사이즈는 \(Int(high*100))% 확률로 \(prediction.size) 입니다."
                }
            }
            addUserData(waist: String(waist), thigh: String(thigh), hem: String(hem), outseam: String(outseam))
        }
        sizeSearchButton.alpha  = 1;
    }

    override func viewWillAppear(_ animated: Bool) {
        sizeCheckButton.layer.borderColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1).cgColor
        sizeCheckButton.layer.borderWidth = 2
        sizeCheckButton.layer.cornerRadius = 2
        sizeSearchButton.layer.borderColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1).cgColor
        sizeSearchButton.layer.borderWidth = 2
        sizeSearchButton.layer.cornerRadius = 2
        sizeSearchButton.alpha  = 0;

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        waistValue.text = String(data[0])
//        thighValue.text = String(data[1])
//        hemValue.text = String(data[2])
//        outseamValue.text = String(data[3])
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: SaveSizeViewController = segue.destination as! SaveSizeViewController
        DestViewController.waistSize = waistValue.text!
        DestViewController.thighSize = thighValue.text!
        DestViewController.hemSize = hemValue.text!
        DestViewController.outseamSize = outseamValue.text!
        //DestViewController.result = result
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func inputSizeToUserSizeData (db : UserSizeInformation, waist: String, thigh: String, hem: String, outseam: String) -> UserSizeInformation {
          
          //Liked.share.saves에 있는 데이터 다 가져와서 . . . .넣고 싶은데... ㅠㅠㅠㅠㅠㅠㅠ
        db.waist = waist
        db.thigh = thigh
        db.hem = hem
        db.outseam = outseam
        return db
      }
    
    func addUserData(waist: String, thigh: String, hem: String, outseam: String){
        userSize = UserSizeInformation()
        userSize = inputSizeToUserSizeData(db: userSize!, waist: waist, thigh: thigh, hem: hem, outseam: outseam)
        //input Realm
        try? usersDB?.write {
            usersDB?.add((userSize)!)
        }
    }
}

class UserSizeInformation: Object  {
    @objc dynamic var waist = ""
    @objc dynamic var thigh = ""
    @objc dynamic var hem = ""
    @objc dynamic var outseam = ""
    
}
