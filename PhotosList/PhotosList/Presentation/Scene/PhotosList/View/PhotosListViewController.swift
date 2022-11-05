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
    
    @IBOutlet private weak var loadingMoreIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    private var photosList = [Photo]()
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
        loadingIndicatorView.isHidden = false
        photosViewModel.getPhotos(start: startPaging)
        subscibeToRespose()
    }
    func registerNib() {
        
        photosCollectioniew.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
    }
    
    func subscibeToRespose(){
        
        photosViewModel.getPhotosList.subscribe(onNext: { [weak self] photos in
            print("subscibeToRespose products \(photos.count), \(self?.photosList.count)")

            self?.loadingIndicatorView.isHidden = true
            self?.loadingMoreIndicatorView.isHidden = true

            if photos.count > 0{
//                for photo in photos {
//                    self?.photosList.append(photo)
//                    }
            self?.photosList.append(contentsOf: photos)
//            self?.photosList = photos

            self?.photosCollectioniew.reloadData()
            }
            
        }).disposed(by: disposebag)
    }

}

extension PhotosListViewController :UICollectionViewDelegate ,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  photosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath as IndexPath) as? PhotoCollectionViewCell {
            
          
                cell.photoCell = self.photosViewModel.getPhotoCell(from: photosList[indexPath.row] )
          
                      
            return cell
        }
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == (photosList.count ) - 1){
            startPaging = startPaging + 10
            loadingMoreIndicatorView.isHidden = false
            photosViewModel.getPhotos(start: startPaging)
        }
    }

   
}
extension PhotosListViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize.init(width: ((photosCollectioniew.frame.width / 2 ) - 10), height: (230 - 10))
    }
    

}
