//
//  PhotoViewController.swift
//  PhotosList
//
//  Created by ahmed sabry on 06/11/2022.
//

import UIKit
import RxCocoa
import RxSwift

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    private let disposebag = DisposeBag()
    var imageURL:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        imageWithZooming()
        subscribeToBackButton()
     
    }
    

    func setUI(){
       
        if (imageURL != "") {
            print("img \(imageURL)")
        guard let imageUrl = URL(string: imageURL) else {return  }
        self.photoImageView.setImage(from: imageUrl)
        }
      
    }
    func imageWithZooming(){
        let vWidth = self.view.frame.width
        let vHeight = self.view.frame.height

            let scrollImg: UIScrollView = UIScrollView()
            scrollImg.delegate = self
            scrollImg.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
            scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
            scrollImg.alwaysBounceVertical = false
            scrollImg.alwaysBounceHorizontal = false
            scrollImg.showsVerticalScrollIndicator = true
            scrollImg.flashScrollIndicators()

            scrollImg.minimumZoomScale = 1.0
            scrollImg.maximumZoomScale = 10.0

//            defaultView!.addSubview(scrollImg)

        photoImageView?.layer.cornerRadius = 11.0
        photoImageView?.clipsToBounds = false
        photoImageView.addSubview(scrollImg)
        
    }
    func subscribeToBackButton(){
        backButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                
                self?.dismiss(animated: true)
                

        }).disposed(by: disposebag)
    }
}
