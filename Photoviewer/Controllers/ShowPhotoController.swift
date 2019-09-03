//
//  ShowPhotoController.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class ShowPhotoController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var largePhotoView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.maximumZoomScale = 5
        self.scrollView.minimumZoomScale = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.largePhotoView.image = currentImage
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return largePhotoView.self
    }
}
