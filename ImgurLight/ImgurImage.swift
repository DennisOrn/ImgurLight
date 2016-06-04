//
//  ImgurImage.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 26/05/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

class ImgurImage: NSObject { // Not used at the moment.
    
    var image: UIImage?
    var id: String?
    
    init(id: String, image: UIImage) {
        self.image = image
        self.id = id
    }
}
