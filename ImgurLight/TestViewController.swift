//
//  TestViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 25/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TestViewController: UIViewController, ImgurAPIDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var API: ImgurAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        API = ImgurAPI()
        API?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        API?.getImagesByTag("cats")
        
        print("after method-call")
        
        /*let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            //self.API?.getIDsByTag("cats")
            
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
            }
        }*/
    }
    
    func APIsetImage(image: UIImage) {
        imageView.image = image
    }
}
