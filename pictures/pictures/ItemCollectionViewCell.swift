//
//  ItemCollectionViewCell.swift
//  pictures
//
//  Created by kudakwashe on 2019/10/12.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
