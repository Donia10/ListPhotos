//
//  ViewController.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import UIKit
import RxSwift

class PhotosListViewController: UIViewController {

    @IBOutlet private weak var photosCollectioniew: UICollectionView!
    private var photosList:[Photo]?
     var photosViewModel = PhotosViewModel()
    var startPaging:Int = 0
    var disposebag:DisposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerNib()
        photosCollectioniew.delegate = self
        photosCollectioniew.dataSource = self

        title = "Photo List"
        photosViewModel.getPhotos(start: startPaging)
        photosViewModel.getPhotosList.subscribe(onNext: { [weak self] photos in
            
            self?.photosList = photos
            self?.photosCollectioniew.reloadData()
            
        }).disposed(by: disposebag)
    }
    func registerNib() {
        
        photosCollectioniew.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
    }

}

extension PhotosListViewController :UICollectionViewDelegate ,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  photosList?.count ?? 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath as IndexPath) as? PhotoCollectionViewCell {
            
            if let photosList = photosList {
                cell.photoCell = self.photosViewModel.getPhotoCell(from: photosList[indexPath.row] )
          
            }
                      
            return cell
        }
        return UICollectionViewCell()
        
    }

   
}
extension PhotosListViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize.init(width: ((photosCollectioniew.frame.width / 2 ) - 10), height: (230 - 10))
    }
    

}
