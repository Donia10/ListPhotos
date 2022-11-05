//
//  FetchPhotosUseCase.swift
//  PhotosList
//
//  Created by donia ashraf on 05/11/2022.
//

import Foundation

class FetchPhotosUseCase {
    
    var photosRepository:PhotosRepository?
   
    init(photosRepository:PhotosRepository = PhotosListRepository()){
        
        self.photosRepository = photosRepository
    }
    
    func getPhotos(start: Int? , limit: Int? ,completion: @escaping(Result<[Photo]?,Error>)-> Void) {
       
        self.photosRepository?.fetchPhotosList(start: start, limit: limit, completion: { (response) in
            switch response {
            case .success(let photos):
                completion(.success(photos))
                
            case .failure(let error):
                completion(.failure(error))
            
            }
        })
    }
}
