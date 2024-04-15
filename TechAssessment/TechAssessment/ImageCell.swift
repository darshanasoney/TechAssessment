//
//  ImageCell.swift
//  TechAssessment
//
//  Created by Darshana  on 14/04/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func populate(user : UserPhoto) {
        if let urlString = user.profileLarge {
            ImageLoader.shared.loadImage(from: urlString) { image in
                self.imageView.image = image
            }
        }
        self.imageView.setCorner()
    }
    
}
