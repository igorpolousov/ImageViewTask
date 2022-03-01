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
    var imagesForCollection = [ImageDate]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Viewer"
        
        let url = URL(string: urlString)

        //request(url: url!)
        fetchData()
        addDate()
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

    // Добавление даты к картинкам
    func addDate() {
        for image in imagesFromServer {
            let imageURL = image.largeImageURL
            let loadDate = getDate()
            let imageDate = ImageDate(imageUrl: imageURL, loadDate: loadDate)
            imagesForCollection.append(imageDate)
        }
    }
   


    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesForCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
    
        cell.applyCellDesign()
        cell.imageForCell.applyCellImageDesign()
        let likesCount = imagesFromServer[indexPath.item].likes
        let viewsCount = imagesFromServer[indexPath.item].views
        
        if let url = URL(string: imagesFromServer[indexPath.item].largeImageURL) {
            if let data = try? Data(contentsOf: url) {
                cell.imageForCell.image = UIImage(data: data)
                
                cell.dateLabel.text = "Likes: \(likesCount) Views: \(viewsCount)"
                return cell
            }
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.receivedImage = imagesFromServer[indexPath.item].largeImageURL
            vc.loadImageDate = imagesForCollection[indexPath.item].loadDate
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveData() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(imagesForCollection) {
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: "images")
        } else {
            let ac = UIAlertController(title: "Failed to save images", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(ac, animated: true)
        }
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        if let savedPictures = defaults.object(forKey: "images") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                try imagesForCollection = jsonDecoder.decode([ImageDate].self, from: savedPictures)
            } catch {
                print("Failed to load data")
            }
        }
    }
}
