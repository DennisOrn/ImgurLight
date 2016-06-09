//
//  SearchViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 09/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

protocol SearchDelegate: class {
    func changeCategory(category: String)
    func dismissController(controller: UIViewController)
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SearchDelegate?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResult = [String]()
    
    let reuseIdentifier = "tableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = searchResult[row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        //cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let text = (cell?.textLabel?.text)!
        delegate?.changeCategory(text)
        delegate?.dismissController(self)
    }
    
    
    
    // MARK: - Navigation
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        delegate?.dismissController(self)
    }
    
    @IBAction func searchButtonPressed(sender: UIBarButtonItem) {
        
        // Clear the search result first.
        searchResult.removeAll()
        tableView.reloadData()
        
        // Check if there is a keyword in the text field.
        let keyword = textField.text!
        if keyword.characters.count == 0 {
            print("type something!")
            return
        }
        
        // Check if there is a whitespace in the text field.
        let whitespace = NSCharacterSet.whitespaceCharacterSet()
        let range = keyword.rangeOfCharacterFromSet(whitespace)
        if range != nil {
            print("whitespace found")
            return
        }
        
        searchResult.append(keyword)
        
        let row = searchResult.indexOf(keyword)!
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    @IBAction func viralButtonPressed(sender: UIButton) {
        delegate?.changeCategory("viral")
        delegate?.dismissController(self)
    }
}
