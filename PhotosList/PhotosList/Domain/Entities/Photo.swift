//
//  Photo.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import Foundation

struct Photo:Codable{
    let albumId:Int?
    let id:Int?
    let title:String?
    let url:String?
    let thumbnailUrl:String?
}
