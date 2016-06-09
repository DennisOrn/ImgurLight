//
//  FavoritesCollectionViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 05/06/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import CoreData

class FavoritesCollectionViewController: UICollectionViewController {
    
    let reuseIdentifier = "favoriteCell"
    var cells = [ImgurImageData]()
    
    var images = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorites"
        
        //updateImageList()
        //reloadView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateImageList()
        reloadView()
    }
    
    func updateImageList() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "ImgurImageData")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            images = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func reloadView() {
        
        cells.removeAll()
        
        for entry in images {
            
            let id = entry.valueForKey("id") as! String
            let data = entry.valueForKey("data") as! NSData
            let isGif = entry.valueForKey("isGif") as! Bool
            
            let imgurImageData = ImgurImageData(id: id, data: data, isGif: isGif)
            
            cells.append(imgurImageData)
            self.collectionView?.reloadData()
        }
    }
    
    @IBAction func refreshButtonPressed(sender: UIBarButtonItem) {
        
        updateImageList()
        reloadView()
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "favoriteShowInfo" {
            
            let controller = segue.destinationViewController as! FavoriteImageInfoViewController
            let imageCell = sender as! ImageCell
            controller.id = imageCell.id
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImageCell
        cell.id = cells[indexPath.row].id
        cell.imageView.image = UIImage(data: cells[indexPath.row].data)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = (UIScreen.mainScreen().bounds.size.width / 2.0) - 2
        return CGSize(width: size, height: size)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
