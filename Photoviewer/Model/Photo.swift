//
//  Photo.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    
    var id: Int = 0
    var previewImage: String = ""
    var largeImage: String = ""
    var likes: Int = 0
    var comments: Int = 0
    var views: Int = 0
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.previewImage = json["webformatURL"].stringValue
        self.largeImage = json["largeImageURL"].stringValue
        self.likes = json["likes"].intValue
        self.comments = json["comments"].intValue
        self.views = json["views"].intValue
    }
    
}
