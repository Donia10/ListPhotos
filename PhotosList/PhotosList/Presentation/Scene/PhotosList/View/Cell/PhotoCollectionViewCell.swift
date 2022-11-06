//
//  PhotoCollectionViewCell.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet  private weak var containerView: UIView!
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    var photoCell:PhotoCell? {
        didSet{
            guard let imageUrl = URL(string: photoCell?.imageUrl ?? "") else {return  }
            
            self.photoImageView.setImage(from: imageUrl)
            self.titleLabel.text = photoCell?.title ?? ""
        }
    }
    
    var naigateToPhoto:(()->()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.isUserInteractionEnabled = true
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))

        photoImageView.addGestureRecognizer(tapGestureRecognizer)
            
         
        
    }
   
    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        print("did tap image view")
        naigateToPhoto()
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//        if let vc = storyBoard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController {
//           // vc.images = [item?.profileImg ?? ""]
//            // self.navigationController?.pushViewController(vc, animated: true)
//            vc.modalPresentationStyle = .overFullScreen
        
    }
    
}
