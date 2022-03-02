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
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let titleToLoad = loadImageDate {
            title = titleToLoad
        }
        
        if let data = receivedImage {
            fullSizeImage.image = UIImage(data: data)
        }
    }
    
    // Making navigation controller dissapear on tap
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    // making navigation controller appear on tap
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
