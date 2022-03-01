//
//  ImageCell.swift
//  ImageViewTask
//
//  Created by Igor Polousov on 01.03.2022.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet var imageForCell: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
}


extension UIImageView {
    func applyCellImageDesign() {
        self.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8
    }
}
extension ImageCell {
    func applyCellDesign() {
        self.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 15
    }
}
