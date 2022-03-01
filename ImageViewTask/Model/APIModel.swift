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
    var likes: Int
    var views: Int
}

// Структура для загрузки данных в collection view image url + date
struct ImageDate: Codable {
    var imageData: Data
    var loadDate: String
    var likes: Int
    var views: Int
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


