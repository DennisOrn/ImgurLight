//
//  FavoriteImageInfoViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 08/06/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit
import CoreData

class FavoriteImageInfoViewController: UIViewController {
    
    var imgurImageData: ImgurImageData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view loaded")
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

}
