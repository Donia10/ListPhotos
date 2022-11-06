//
//  PhotoViewController.swift
//  PhotosList
//
//  Created by ahmed sabry on 06/11/2022.
//

import UIKit
import RxCocoa
import RxSwift

class PhotoViewController: UIViewController {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    let disposebag = DisposeBag()

    var imageURL:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (imageURL != "") {
            print("img \(imageURL)")
        guard let imageUrl = URL(string: imageURL) else {return  }
        self.photoImageView.setImage(from: imageUrl, withPlaceholder: UIImage(named:""))
        }
        
        backButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                
                self?.dismiss(animated: true)
                

        }).disposed(by: disposebag)
    }
    

}
