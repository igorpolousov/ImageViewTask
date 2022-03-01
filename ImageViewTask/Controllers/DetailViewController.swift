//
//  DetailViewController.swift
//  ImageViewTask
//
//  Created by Igor Polousov on 01.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var fullSizeImage: UIImageView!
    var receivedImage: String?
    var loadImageDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let titleToLoad = loadImageDate {
            title = titleToLoad
        }
        
        if let url = URL(string: receivedImage!) {
            if let data = try? Data(contentsOf: url) {
                fullSizeImage.image = UIImage(data: data)
            }
        }
        
    }

}
