//
//  ExtensionUIImageView.swift
//  PhotosList
//
//  Created by ahmed sabry on 05/11/2022.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        
        URLSession.shared.dataTask(with: url) { [weak self](data, _, _) in
//          session.dataTask(with: url) { [weak self](data, _, _) in

            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}
