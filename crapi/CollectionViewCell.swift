//
//  CollectionViewCell.swift
//  crapi
//
//  Created by wayo on 26/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var valueViewCell: UILabel!
    @IBOutlet weak var titleViewCell: UILabel!
    
    func displayContent(with model: ProfileCollectionViewModel){
        imageViewCell.image = model.image
        titleViewCell.text = model.title
        valueViewCell.text = model.value
    }
    
}
