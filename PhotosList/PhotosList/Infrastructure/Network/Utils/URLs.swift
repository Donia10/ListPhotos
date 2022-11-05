//
//  URLs.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import Foundation

class URLs{
    static func urls(start:Int? = 0,limit:Int? = 10)->String{
        return "https://jsonplaceholder.typicode.com/photos?_start=\(start ?? 0)&_limit=\(limit ?? 10)"
    }
}
