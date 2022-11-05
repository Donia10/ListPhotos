//
//  PhotosViewModel.swift
//  PhotosList
//
//  Created by donia ashraf on 05/11/2022.
//

import Foundation
import RxSwift
import RxCocoa


protocol PhotosViewModelProtocol {
    var fetchPhotosUseCase:FetchPhotosUseCase? { get set }
    
    var photos: PublishSubject<[Photo]> { get set }
    

}
class PhotosViewModel:PhotosViewModelProtocol {
     
    var fetchPhotosUseCase:FetchPhotosUseCase?
    
    var photos = PublishSubject<[Photo]>()
    
    var getPhotosList: Observable<[Photo]> {
        return photos
    }
    init (fetchPhotosUseCase:FetchPhotosUseCase = FetchPhotosUseCase()) {
        
        self.fetchPhotosUseCase = fetchPhotosUseCase
    }
    
    func getPhotos(start: Int? = 0 ){
        
        fetchPhotosUseCase?.getPhotos(start: start, limit: 10, completion: {
            [weak self](response) in
            
            switch (response) {
            case .failure(let error ):
                print(error)
            case .success(let photos):
                guard let photos = photos else { return }
                self?.photos.onNext(photos)
            }
            
        })
        
    }
    
}
extension PhotosViewModel {
    
    func getPhotoCell(from photo: Photo) -> PhotoCell {
        
        return PhotoCell(title: photo.title, imageUrl: photo.thumbnailUrl)
    }
}
