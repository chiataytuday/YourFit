//
//  LikeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/15.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit

class LikeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return Liked.shared.saves.count
    }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTableViewCell", for: indexPath) as! LikeTableViewCell
            let rowData = Liked.shared.saves[indexPath.row]
           cell.modelLabel.text = rowData.model
           cell.brandLabel.text = rowData.brand
           cell.priceLabel.text = "\(rowData.price)"
           cell.recommendSizeLabel.text = rowData.recommendSize
           return cell
       }
    
    @IBOutlet weak var likeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeTableView.dataSource = self
        likeTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.collectionView.reloadData()
       // collectionView.dataSource = self
    }
}
