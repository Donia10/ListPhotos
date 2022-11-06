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

            self?.loadingIndicatorView.isHidden = true
            self?.loadingMoreIndicatorView.isHidden = true

            if photos.count > 0{
            self?.photosList.append(contentsOf: photos)
//                print("subscibeToRespose products \(photos.count), \(self?.photosList.count)")

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
            cell.naigateToPhoto =  {
                print("img \(self.photosList[indexPath.row].thumbnailUrl ?? "")")
                print("url \(self.photosList[indexPath.row].url ?? "")")

                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController {
                    vc.imageURL = self.photosList[indexPath.row].url ?? ""
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
                      
            return cell
        }
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        loadingMoreIndicatorView.isHidden = true
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
