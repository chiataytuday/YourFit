//
//  ClothInformationCollectionViewCell.swift
//  size
//
//  Created by dgulinc on 2020/02/02.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit

class ClothInformationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var discountRate: UILabel!
    @IBOutlet weak var realPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
