//
//  ShowPhotoController.swift
//  Photoviewer
//
//  Created by ILYA Karasev on 02/09/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class ShowPhotoController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!    // чтобы иметь возможность передвигаться по увеличенному фото добавляем scroll view
    @IBOutlet weak var largePhotoView: UIImageView! 
    
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.maximumZoomScale = 5    // добавляем возможность увеличивать фото в 5 раз
        self.scrollView.minimumZoomScale = 1    // минимальный размер изображения будет равен его размеру при появлении фото
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.largePhotoView.image = currentImage
        
        self.navigationController?.setNavigationBarHidden(false, animated: false) // добавляем возможность скрыть navigation bar по нажатию
        self.navigationController?.hidesBarsOnTap = true                          // чтобы он не мешал просмотру фото
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return largePhotoView.self
    }
}
