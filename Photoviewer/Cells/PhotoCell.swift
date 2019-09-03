//
//  PhotoCell.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCell"
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    var largeImageView = UIImageView()
    
    public func configure(with photo: Photo) {
        
        let photoUrlString = photo.previewImage
        photoView.kf.setImage(with: URL(string: photoUrlString))
        
        let largePhotoUrlString = photo.largeImage
        largeImageView.kf.setImage(with: URL(string: largePhotoUrlString))
        
        let likes = photo.likes
        likesLabel.text = String(likes)
        
        let comments = photo.comments
        commentsLabel.text = String(comments)
        
        let views = photo.views
        viewsLabel.text = String(views)
    }
}
