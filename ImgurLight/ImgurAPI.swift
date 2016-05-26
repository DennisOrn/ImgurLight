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
    optional func APIsetImages(images: [UIImage])
}

class ImgurAPI: NSObject { // Singleton?
    
    weak var delegate: ImgurAPIDelegate?
    
    let apiBase = "https://api.imgur.com/3/"
    let urlBase = "https://i.imgur.com/"
    let header = ["Authorization": "Client-ID f21d9d4d90b2e19"]
    
    let imageQuality = "m" // t = small, m = medium, l = large, h = huge, "" = normal
    
    func getImageById(id: String) {
        
        Alamofire.request(.GET, urlBase + id + imageQuality + ".jpg")
            .responseJSON { response in
                
                if let data = response.data {
                    
                    let image = UIImage(data: data, scale: 1)
                    if image != nil {
                        //image!.id = id
                        let imgurImage = ImgurImage(id: id, image: image!)
                        self.delegate?.APIsetImage?(imgurImage)
                    }
                }
        }
    }
    
    /*func getImagesByTag(tag: String) {
        
        Alamofire.request(.GET, apiBase + "gallery/t/" + tag, headers: header)
            .responseJSON { response in
                
                if let jsonData = response.result.value {
                    let json = JSON(jsonData)
                    //print(json)
                    //print(json["data"])
                    
                    var idList = [String]()
                    var imageList = [UIImage]()
                    
                    for item in json["data"]["items"].arrayValue {
                        //print(item)
                        idList.append(item["id"].stringValue)
                    }
                }
        }
    }*/
    
    
    
    
    
    func getImagesByTag(tag: String) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
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
            print(idList)
            
            let group = dispatch_group_create()
            for id in idList {
                
                dispatch_group_enter(group)
                Alamofire.request(.GET, self.urlBase + id + self.imageQuality + ".jpg")
                    .responseJSON { response in
                        
                        if let data = response.data {
                            
                            let image = UIImage(data: data, scale: 1)
                            if image != nil {
                                let imgurImage = ImgurImage(id: id, image: image!)
                                self.delegate?.APIsetImage?(imgurImage)
                            }
                        }
                        dispatch_group_leave(group)
                }
            }
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
            print("getImagesByTag DONE!")
        }
    }
}