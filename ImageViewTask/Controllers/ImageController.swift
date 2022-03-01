//
//  ImageController.swift
//  ImageViewTask
//
//  Created by Igor Polousov on 01.03.2022.
//

import UIKit



class ImageController: UICollectionViewController {

    private let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Image Viewer"

    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
    
        cell.applyCellDesign()
        cell.imageForCell.applyCellImageDesign()
        
        let cellData = images[indexPath.item]
        
        cell.imageForCell.image = cellData.image
        cell.dateLabel.text = cellData.date
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.receivedImage = images[indexPath.item].image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
