//
//  ImageInfoViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 09/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

class ImageInfoViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var text: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = text
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
