//
//  ImageInfoViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 09/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import Gifu
import CoreData

class ImageInfoViewController: UIViewController, ImgurAPIDelegate {
    
    var API: ImgurAPI?
    
    let imageQuality = "" // t = small, m = medium, l = large, h = huge, "" = normal (must have 'normal' for gifs to work)
    
    var id: String?
    var imgurImageData: ImgurImageData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(
            title: "Save",
            style: .Plain,
            target: self,
            action: #selector(ImageInfoViewController.saveImage)
        )
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        API = ImgurAPI()
        API?.delegate = self
        API?.getImageById(id!, quality: imageQuality)
    }
    
    func saveImage() {
        
        if let imageData = imgurImageData {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            let entity =  NSEntityDescription.entityForName("ImgurImageData", inManagedObjectContext:managedContext)
            let image = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            image.setValue(imageData.id, forKey: "id")
            image.setValue(imageData.data, forKey: "data")
            image.setValue(imageData.isGif, forKey: "isGif")
            
            do {
                try managedContext.save()
                print("Image saved")
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    func APISetImage(imgurImageData: ImgurImageData) {
        
        self.imgurImageData = imgurImageData
        
        if imgurImageData.isGif == true {
            
            let dummyImage = UIImage(data: imgurImageData.data!)
            let heightToWidth = dummyImage!.size.height / dummyImage!.size.width
            
            let imageView = AnimatableImageView()
            imageView.animateWithImageData(imgurImageData.data!)
            imageView.frame = CGRect(
                x: 0,
                y: 64,
                width: self.view.bounds.width,
                height: self.view.bounds.width * heightToWidth)
            
            view.addSubview(imageView)
            
        } else {
            
            let image = UIImage(data: imgurImageData.data!)
            let heightToWidth = image!.size.height / image!.size.width
            
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(
                x: 0,
                y: 64,
                width: view.bounds.width,
                height: view.bounds.width * heightToWidth)
            
            view.addSubview(imageView)
        }
    }
}
