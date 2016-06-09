//
//  FavoriteImageInfoViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 08/06/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import Gifu
import CoreData

class FavoriteImageInfoViewController: UIViewController {
    
    var id: String?
    var imgurImageData: ImgurImageData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let removeButton = UIBarButtonItem(
            title: "Remove",
            style: .Plain,
            target: self,
            action: #selector(FavoriteImageInfoViewController.removeImage)
        )
        
        self.navigationItem.rightBarButtonItem = removeButton
        
        var imageObject: [NSManagedObject]?
        var imgurImageData: ImgurImageData?
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "ImgurImageData")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id!)
        fetchRequest.fetchLimit = 1
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            imageObject = result as? [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        if imageObject != nil {
            
            let id = imageObject![0].valueForKey("id") as! String
            let data = imageObject![0].valueForKey("data") as! NSData
            let isGif = imageObject![0].valueForKey("isGif") as! Bool
            
            imgurImageData = ImgurImageData(id: id, data: data, isGif: isGif)
            
            if imgurImageData != nil {
                
                if imgurImageData!.isGif == true {
                    
                    let dummyImage = UIImage(data: imgurImageData!.data)
                    let heightToWidth = dummyImage!.size.height / dummyImage!.size.width
                    
                    let imageView = AnimatableImageView()
                    imageView.animateWithImageData(imgurImageData!.data)
                    imageView.frame = CGRect(
                        x: 0,
                        y: 64,
                        width: self.view.bounds.width,
                        height: self.view.bounds.width * heightToWidth)
                    
                    view.addSubview(imageView)
                    
                } else {
                    
                    let image = UIImage(data: imgurImageData!.data)
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
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParentViewController() {
            
            let parent = parentViewController?.childViewControllers[0] as! FavoritesCollectionViewController
            parent.updateImageList()
            parent.reloadView()
        }
    }
    
    func removeImage() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "ImgurImageData")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id!)
        
        do {
            let fetchedEntities = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            if let entityToDelete = fetchedEntities.first {
                managedContext.deleteObject(entityToDelete)
                print("Image removed")
            }
        } catch {
            print("Could not fetch entity")
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Could not save context")
        }
    }
}
