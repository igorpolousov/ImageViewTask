//
//  DetailViewController.swift
//  ImageViewTask
//
//  Created by Igor Polousov on 01.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var fullSizeImage: UIImageView!
    var receivedImage: Data?
    var loadImageDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let titleToLoad = loadImageDate {
            title = titleToLoad
        }
        
        if let data = receivedImage {
            fullSizeImage.image = UIImage(data: data)
        }
    }
}
