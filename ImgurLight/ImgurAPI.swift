//
//  ImgurAPI.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 25/05/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import Alamofire

protocol ImgurAPIDelegate: class {
    func APIsetImage(image: UIImage)
}

class ImgurAPI: NSObject {
    
    weak var delegate: ImgurAPIDelegate?
    
    let urlBase = "https://i.imgur.com/"
    
    func getImageById(id: String) {
        
        Alamofire.request(.GET, urlBase + id + ".jpg")
            .responseJSON { response in
                
                if let data = response.data {
                    let image = UIImage(data: data, scale: 1)
                    if image != nil {
                        self.delegate?.APIsetImage(image!)
                    }
                }
        }
    }
}