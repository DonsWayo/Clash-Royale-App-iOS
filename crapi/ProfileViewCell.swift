//
//  ProfileViewCell.swift
//  crapi
//
//  Created by wayo on 26/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import UIKit

class ProfileViewCell: UICollectionViewCell{
    
    @IBOutlet weak var valueTxt: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: ProfileCollectionViewModel) {
        valueTxt.text = model.value
        titleTxt.text = model.title
        imageView.image = model.image
    }
}
