//
//  EnterSizeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/20.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit

class EnterSizeViewController: UIViewController {

    private let model = SizeTabularClassifier()

    @IBOutlet weak var waistValue: UITextField!
    @IBOutlet weak var thighValue: UITextField!
    @IBOutlet weak var hemValue: UITextField!
    @IBOutlet weak var outseamValue: UITextField!
    @IBOutlet weak var probability: UILabel!
    
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
                    probability.text = "\(Int(high*100))% 확률로 \(prediction.size) 에 있습니다."
                }
            }
        }
    }

        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let DestViewController: ViewController = segue.destination as! ViewController
            
        DestViewController.waistSize = waistValue.text!
        DestViewController.thighSize = thighValue.text!
        DestViewController.hemSize = hemValue.text!
        DestViewController.outseamSize = outseamValue.text!
        DestViewController.result = result
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
