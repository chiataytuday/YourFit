//
//  ViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/08.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource {

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return self.ClothMenu.count
 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClothInformationCell", for: indexPath) as! ClothInformationCell
        let rowData = self.ClothMenu[indexPath.row]
        
        cell.model.text = rowData.model
        cell.brand.text = rowData.brand
        cell.price.text = "\(rowData.price)"
        cell.recommendSize.text = rowData.recommendSize
        return cell
    }
    
    @IBOutlet weak var clothTableView: UITableView!
    let ClothMenu:[Cloth] = [
               Cloth(model:"Heritage black mannish crop fit",brand:"FATALISM",price:68600,clothImage: nil,url:"https://store.musinsa.com/app/product/detail/947581/0", recommendSize: "S")
               
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        clothTableView.dataSource = self
        clothTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clothDetail" {
            let menu = sender as? Cloth
            if menu != nil {
                let detailController = segue.destination as? ClothDetailViewController
                if detailController != nil {
                    detailController!.clothDetail = menu

                }
            }
            
        }
    }
   
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           performSegue(withIdentifier: "clothDetail", sender: self.ClothMenu[indexPath.row])
       }
}

