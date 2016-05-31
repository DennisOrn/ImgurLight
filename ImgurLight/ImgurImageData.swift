//
//  ImgurImageData.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 31/05/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

class ImgurImageData: NSObject {
    
    var imageData: NSData?
    var id: String?
    
    init(id: String, imageData: NSData) {
        self.id = id
        self.imageData = imageData
    }
}
