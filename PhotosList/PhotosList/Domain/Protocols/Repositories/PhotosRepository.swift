//
//  PhotosRepository.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import Foundation

protocol PhotosRepository {
    func fetchPhotosList (start:Int? , limit:Int?, completion: @escaping(Result<[Photo]?,Error>)-> Void) 
    
}
