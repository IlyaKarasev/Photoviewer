//
//  CashPhotoService.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 05/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import Alamofire

class СachePhotoService {
    
    // Время хранения в течении которого кэш считается актуальным:
    
    private let cacheLifeTime: TimeInterval = 3 * 24 * 60 * 60
    
    // Имя папки в которой будут храниться изображения:
    
    private static let pathName: String = {
        
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    } ()
    
    // Метод, который возвращает на основе url путь к файлу для сохранения или загрузки:
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hasheName = String(describing: url.hashValue)
        return cachesDirectory.appendingPathComponent(СachePhotoService.pathName + "/" + hasheName).path
    }
    
    // Метод, который сохраняет изображение в файловой системе:
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url) else { return }
        let data = image.pngData()
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    // Метод, который загружает изображение из файловой системы:
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else {return nil }
        
        images[url] = image
        return image
    }
    
    // Cловарь в котором будут храниться загруженные и извлеченные из файловой системы изображения (кэш в оператиной памяти):
    private var images = [String: UIImage]()
    
    // Метод загрузки фото из сети:
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        
    }

    // Метод, который предоставляет изображение по url (сначала ищем кэше оперативной памяти, потом в файловой системе, если нигде нет - загружаем из сети):
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension СachePhotoService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
