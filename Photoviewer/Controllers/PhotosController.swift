//
//  PhotosController.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class PhotosController: UICollectionViewController {

    private let getPhotoService = NetworkingService()
    var photoService: СachePhotoService?
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular Photos"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getPhotoService.loadPhotos() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.photos = photos
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: customizing of collection view
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        
        cell.photoView.image = photoService?.photo(atIndexpath: indexPath, byUrl: photo.previewImage)
        cell.photoView.kf.setImage(with: URL(string: photo.previewImage))
        
        cell.largeImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: photo.largeImage)
        cell.largeImageView.kf.setImage(with: URL(string: photo.largeImage))
        
        let likes = photo.likes
        cell.likesLabel.text = String(likes)
        
        let comments = photo.comments
        cell.commentsLabel.text = String(comments)
        
        let views = photo.views
        cell.viewsLabel.text = String(views)
    
        return cell
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto",
            let showPhotoVC = segue.destination as? ShowPhotoController {

            let cell = sender as! PhotoCell
            let largePhoto = cell.largeImageView.image
            showPhotoVC.currentImage = largePhoto
        }
    }
}
