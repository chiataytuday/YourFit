//
//  ViewController.swift
//  ARSampleApp
//
//  Created by Pawel Chmiel on 13.07.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class measureViewController: UIViewController, ARSCNViewDelegate {

    var progressLevel = 0
    var measureSize :[Float] = [] //
    var realtimeSize :Float = 0.0
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var aimLabel: UILabel!
    @IBOutlet weak var notReadyLabel: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var waistLabel: UILabel!
    @IBOutlet weak var thighLabel: UILabel!
    @IBOutlet weak var hemLabel: UILabel!
    @IBOutlet weak var outseamLabel: UILabel!
    
    
    let session = ARSession()
    let vectorZero = SCNVector3()
    let sessionConfig: ARConfiguration = ARWorldTrackingConfiguration()
    var measuring = false
    var startValue = SCNVector3()
    var endValue = SCNVector3()
    
    override func viewDidLoad() {
        endOfMeasure.isHidden = true
        super.viewDidLoad()
        setupScene()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        endOfMeasure.layer.borderColor = UIColor(red: 78/255, green: 73/255, blue: 207/255, alpha: 1).cgColor
        endOfMeasure.layer.borderWidth = 2
        endOfMeasure.layer.cornerRadius = 2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.pause()
    }
    
    func setupScene() {
        sceneView.delegate = self
        sceneView.session = session
        session.run(sessionConfig, options: [.resetTracking, .removeExistingAnchors])
        resetValues()
    }
    
    func resetValues() {
        measuring = false
        startValue = SCNVector3()
        endValue =  SCNVector3()
        
        updateResultLabel(0.0)
    }
    
    func updateResultLabel(_ value: Float) {
        let cm = value * 100.0
        resultLabel.text = String(format: "%.2f",cm)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.detectObjects()
        }
    }
    
    func detectObjects() {
        var onesizeMeasure:Float = 0.0
        
        if let worldPos = sceneView.realWorldVector(screenPos: view.center) {
            aimLabel.isHidden = false
            notReadyLabel.isHidden = true
            //notReadyLabel.text = "눌렀다가 떼주세요"
            if measuring {
                if startValue == vectorZero {
                    startValue = worldPos
                }
                endValue = worldPos
                updateResultLabel(startValue.distance(from: endValue))
                onesizeMeasure = startValue.distance(from: endValue)
            }
            realtimeSize = onesizeMeasure
            }
        }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //notReadyLabel.text = ""
        if progressLevel < 4{
        resetValues()
        measuring = true
        }
        else {
            print("측정을종료합니다.")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //notReadyLabel.text = "눌렀다가 떼주세요"
        measuring = false
        if progressLevel != 4{
        measureSize.append(realtimeSize * 100)
        progressLevel += 1
        }
        
        if(progressLevel == 1){
            waistLabel.text = "\(measureSize[0])"
        }
        else if(progressLevel == 2){
            outseamLabel.text = "\(measureSize[1])"
        }
        else if(progressLevel == 3){
                   thighLabel.text = "\(measureSize[2])"
               }
        else if(progressLevel == 4){
                   hemLabel.text = "\(measureSize[3])"
            endOfMeasure.isHidden = false
               }
        
}
   
    
    @IBOutlet weak var endOfMeasure: UIButton!
    
    
}
