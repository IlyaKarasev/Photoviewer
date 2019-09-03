//
//  Photo.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class Photo: Object {
    
    dynamic var id: Int = 0                 // id фотографии
    dynamic var previewImage: String = ""   // изображение небольшого размера для показа на экране с collection view
    dynamic var largeImage: String = ""     // изображение большого размера для показа на экране
    dynamic var likes: Int = 0              // кол-во лайков
    dynamic var comments: Int = 0           // кол-во комментариев
    dynamic var views: Int = 0              // количество просмотров
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.previewImage = json["webformatURL"].stringValue
        self.largeImage = json["largeImageURL"].stringValue
        self.likes = json["likes"].intValue
        self.comments = json["comments"].intValue
        self.views = json["views"].intValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
