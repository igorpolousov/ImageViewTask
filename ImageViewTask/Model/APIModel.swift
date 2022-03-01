//
//  APIModel.swift
//  ImageViewTask
//
//  Created by Igor Polousov on 01.03.2022.
//

import Foundation
import UIKit

// MARK: API Struct
struct ImageContainer: Codable {
    var hits: [Image]
}

struct Image: Codable {
    var largeImageURL: String
}

// Структура для загрузки данных в collection view image url + date
struct ImageDate {
    var imageUrl: String
    var loadDate: String
}

// Указание даты скачивания картинки
func getDate() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.YYYY"
    let formatedDate = dateFormatter.string(from: date as Date)
    return formatedDate
}



// Ответ сервера на запрос для составления структуры получения данных JSON
func request(url: URL) {
    let session = URLSession.shared
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) { data, response, error in
        let json =  try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
        let jsonData = try? JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
        print(String(decoding: jsonData!, as: UTF8.self))
    
    }
    task.resume()
}

 // Структура для проверки работы интерфейса
struct ImageTalantix {
    var date: String
    var image: UIImage
}

// Массив картинок для проверки работы интерфейса
var images = [
    ImageTalantix(date: "22.02.2022", image: UIImage.init(imageLiteralResourceName: "nssl0033")),
    ImageTalantix(date: "15.06.2019", image: UIImage.init(imageLiteralResourceName: "nssl0034")),
    ImageTalantix(date: "17.11.2018", image: UIImage.init(imageLiteralResourceName: "nssl0041")),
    ImageTalantix(date: "19.08.2021", image: UIImage.init(imageLiteralResourceName: "nssl0049")),
    ImageTalantix(date: "09.09.1990", image: UIImage.init(imageLiteralResourceName: "nssl0051")),
    ImageTalantix(date: "12.12.1998", image: UIImage.init(imageLiteralResourceName: "nssl0091"))
]
