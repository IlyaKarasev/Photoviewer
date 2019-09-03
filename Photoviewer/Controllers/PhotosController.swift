//
//  PhotosController.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import RealmSwift

class PhotosController: UICollectionViewController {

    private let photoService = NetworkingService()
    private lazy var photos: Results<Photo> = try! Realm().objects(Photo.self)
    //var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular Photos"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        photoService.loadPhotos() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                //self.photos = photos
                let realm = try! Realm()
                try! realm.write {
                    realm.add(photos, update: .modified)
                }
                print(realm.configuration.fileURL!)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        let width = collectionView.bounds.width / 2.05
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width * 0.82)
        layout.sectionInset = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 0.0, right: 3.0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
    }
    
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell
            else { fatalError() }
    
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto",
            let showPhotoVC = segue.destination as? ShowPhotoController {
            
            let cell = sender as! PhotoCell
            let largePhoto = cell.largeImageView.image
            showPhotoVC.currentImage = largePhoto
        }
    }
    
}
