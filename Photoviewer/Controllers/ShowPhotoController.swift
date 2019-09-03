//
//  ShowPhotoController.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class ShowPhotoController: UIViewController {

    @IBOutlet weak var largePhotoView: UIImageView!
    
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.largePhotoView.image = currentImage
    }

}
