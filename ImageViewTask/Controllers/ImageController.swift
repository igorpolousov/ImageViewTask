//
//  ImageController.swift
//  ImageViewTask
//
//  Created by Igor Polousov on 01.03.2022.
//

import UIKit

class ImageController: UICollectionViewController {

    private let reuseIdentifier = "Cell"
    
    let apiKey = "25936770-73650d518ff8e40b1b22606c0"
    let urlString = "https://pixabay.com/api/?key=25936770-73650d518ff8e40b1b22606c0&q=yellow+flowers&image_type=photo"
    
    
    var imagesFromServer = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)

        request(url: url!)
        fetchData()
        
        title = "Image Viewer"

    }
    
    // MARK: Get data from server
   
    
    func fetchData() {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }

    // Парсинг данных
    func parse(json: Data) {
        let decoder = JSONDecoder()
        // Если данные получены
        if let jsonImages = try? decoder.decode(ImageContainer.self, from: json) {
            imagesFromServer = jsonImages.hits
            // Если произошла ошибка при получении данных
        } else if imagesFromServer.isEmpty {
            let ac = UIAlertController(title: "No Images loaded", message: "There was some problem", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
        }
    }

   


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesFromServer.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
    
        cell.applyCellDesign()
        cell.imageForCell.applyCellImageDesign()
        
        if let url = URL(string: imagesFromServer[indexPath.item].largeImageURL) {
            if let data = try? Data(contentsOf: url) {
                cell.imageForCell.image = UIImage(data: data)
            }
        }

        //cell.dateLabel.text = cellData.date
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.receivedImage = images[indexPath.item].image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
