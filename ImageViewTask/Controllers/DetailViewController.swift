//
//  DetailViewController.swift
//  ImageViewTask
//
//  Created by Igor Polousov on 01.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var fullSizeImage: UIImageView!
    var receivedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = receivedImage {
            fullSizeImage.image = imageToLoad
        }
        
    }

}
