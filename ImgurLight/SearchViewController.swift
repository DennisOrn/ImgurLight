//
//  SearchViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 09/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

protocol SearchDelegate: class {
    func performSearch(keyword: String)
}

class SearchViewController: UIViewController {
    
    weak var delegate: SearchDelegate?
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func searchButtonPressed(sender: UIBarButtonItem) {
        let keyword = textField.text
        if keyword?.characters.count == 0 {
            print("type something!")
            return
        }
        delegate?.performSearch(keyword!)
        /*
         IS IT BETTER TO FETCH THE RESULT HERE OR IN THE MAIN CONTROLLER?
         */
        dismissViewControllerAnimated(true, completion: {})
    }

    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
