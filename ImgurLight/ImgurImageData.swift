//
//  ImgurImageData.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 31/05/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

class ImgurImageData: NSObject {
    
    let id: String
    let data: NSData
    let isGif: Bool
    
    init(id: String, data: NSData, isGif: Bool) {
        self.id = id
        self.data = data
        self.isGif = isGif
    }
}
