//
//  ImgurAPI.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 25/05/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@objc protocol ImgurAPIDelegate: class {
    optional func APIsetImage(imgurImage: ImgurImage)
}

class ImgurAPI: NSObject { // Singleton?
    
    weak var delegate: ImgurAPIDelegate?
    
    let apiBase = "https://api.imgur.com/3/"
    let urlBase = "https://i.imgur.com/"
    let header = ["Authorization": "Client-ID f21d9d4d90b2e19"]
    
    let thumbnailQuality = "t" // t = small, m = medium, l = large, h = huge, "" = normal
    
    func getImageById(id: String, quality: String) {
        
        Alamofire.request(.GET, urlBase + id + quality + ".jpg")
            .responseJSON { response in
                
                if let data = response.data {
                    
                    let image = UIImage(data: data, scale: 1)
                    if image != nil {
                        
                        let imgurImage = ImgurImage(id: id, image: image!)
                        self.delegate?.APIsetImage?(imgurImage)
                        print("getImageById DONE!")
                    }
                }
        }
    }
    
    func getImagesByTag(tag: String) {
        
        //let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            var idList = [String]()
            let semaphore = dispatch_semaphore_create(0)
        
            Alamofire.request(.GET, self.apiBase + "gallery/t/" + tag, headers: self.header)
                .responseJSON { response in
                    
                    if let jsonData = response.result.value {
                        
                        let json = JSON(jsonData)
                        for item in json["data"]["items"].arrayValue {
                            
                            idList.append(item["id"].stringValue)
                        }
                    }
                    dispatch_semaphore_signal(semaphore)
            }
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            print("fetching images: \(idList)")
            
            let group = dispatch_group_create()
            for id in idList {
                
                dispatch_group_enter(group)
                Alamofire.request(.GET, self.urlBase + id + self.thumbnailQuality + ".jpg")
                    .responseJSON { response in
                        
                        if let data = response.data {
                            
                            let reponseUrl = response.response?.URL?.absoluteString
                            
                            if reponseUrl!.containsString("https://i.imgur.com/removed.png") {
                                print("\(id): not found")
                            } else {
                                let image = UIImage(data: data, scale: 1)
                                if image != nil {
                                    
                                    let imgurImage = ImgurImage(id: id, image: image!)
                                    self.delegate?.APIsetImage?(imgurImage)
                                }
                            }
                        }
                        dispatch_group_leave(group)
                }
            }
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER) // dispatch_group can be removed if nothing more is done after this line.
            print("getImagesByTag DONE!")
        }
    }
}
