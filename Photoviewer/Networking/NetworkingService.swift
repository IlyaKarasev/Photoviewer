//
//  NetworkingService.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingService {
    
    //Общая часть URL для всех запросов:
    let baseUrl = "https://pixabay.com/api/"
    
    //Создаем свою сессию с определенными параметрами:
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let session = SessionManager(configuration: config)
        return session
    }()
    
    // Получение фотографий
    public func loadPhotos(completion: ((Swift.Result<[Photo], Error>) -> Void)? = nil) {
        
        let params: Parameters = [
            "key": "13492509-7b57a726ec6e2283a03a51022",
            "image_type": "photo",
            "order": "popular",
            "per_page": "200"
        ]
        
        NetworkingService.session.request(baseUrl, method: .get, parameters: params).responseJSON { response in
            switch response.result  {
            case .success(let value):
                let json = JSON(value)
                let photos = json["hits"].arrayValue.map { Photo($0) }
                completion?(.success(photos))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}


