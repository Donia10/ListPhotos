//
//  PhotoCollectionViewCell.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet  private weak var containerView: UIView!
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    var photoCell:PhotoCell? {
        didSet{
            guard let imageUrl = URL(string: photoCell?.imageUrl ?? "") else {return  }
            
            self.photoImageView.setImage(from: imageUrl, withPlaceholder: UIImage(named:""))
            self.titleLabel.text = photoCell?.title ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        titleLabel.text = "photo List"
    }
    
}
