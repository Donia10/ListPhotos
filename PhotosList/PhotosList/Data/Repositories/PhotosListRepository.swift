//
//  PhotosRepository.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import Foundation


class PhotosListRepository :PhotosRepository {

    var network:NetworkServiceProtocol?
    
    init(network:NetworkServiceProtocol? = NetworkService()) {
        
        self.network = network
    }
    
    
    func fetchPhotosList(start: Int?, limit: Int?, completion: @escaping (Result<[Photo]?,Error>)-> Void)  {
        
        network?.getPhotos(start: start, limit: limit, completion: {
            [weak self] (response) in
            switch response {
            case .success(let photos):
                completion(.success(photos))
                
            case .failure(let error):
                completion(.failure(error))
            
            }
        })
        
        
    }
    
   
    
 

    
    
}
