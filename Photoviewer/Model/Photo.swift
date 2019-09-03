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
    
    dynamic var id: Int = 0
    dynamic var previewImage: String = ""
    dynamic var largeImage: String = ""
    dynamic var likes: Int = 0
    dynamic var comments: Int = 0
    dynamic var views: Int = 0
    
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
