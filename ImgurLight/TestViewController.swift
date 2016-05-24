//
//  TestViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 25/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let ClientID = "f69a0d8f212a0f8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        print("button pressed")
        
        let url = NSURL(string: "https://api.imgur.com/oauth2/authorize?client_id=" + ClientID + "&response_type=token")!
        //let url = NSURL(string: "https://httpbin.org/ip")!
        let request = NSURLRequest(URL: url)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                print(json)
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            
            /*if error != nil {
                print("error")
            } else {
                //let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
                
                
                print(response)
                //print(result)
            }*/
        }.resume()
    }
}
