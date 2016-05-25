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

class TestViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        Alamofire.request(.GET, "https://api.imgur.com/3/topics/defaults")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let json = response.result.value {
                    //print("JSON: \(JSON)")
                    
                    /*let response = json as! NSDictionary
                     let data = response.objectForKey("data")!
                     print(data.dynamicType)
                     print(data.count)*/
                    //print(data.firstObject)
                    
                    let data = JSON(json)
                    print(data)
                    print("\n\n")
                    for item in data["data"].arrayValue {
                        print(item["description"].stringValue)
                    }
                    
                    
                    //self.label.text = "asd\nasd\nasd"//JSON as? String
                }
        }
    }
}
