//
//  ImageInfoViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 09/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import Gifu

class ImageInfoViewController: UIViewController, ImgurAPIDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    var API: ImgurAPI?
    
    let imageQuality = "l" // t = small, m = medium, l = large, h = huge, "" = normal
    
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API = ImgurAPI()
        API?.delegate = self
        API?.getImageById(id!, quality: imageQuality)
        
        label.text = id
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func APISetImage(imgurImageData: ImgurImageData) {
        
        if imgurImageData.isGif == true {
            
            print("GIF!")
            
            label.text = label.text! + " GIF"
            
            let imageView = AnimatableImageView()
            imageView.frame = CGRect(
                x: 0,
                y: 64,
                width: self.view.bounds.width,
                height: self.view.bounds.width)
            imageView.animateWithImageData(imgurImageData.data!)
            
            view.addSubview(imageView)
            
        } else {
            
            print("NOT GIF!")
            
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
