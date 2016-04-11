//
//  SearchViewController.swift
//  ImgurLight
//
//  Created by Dennis Örnberg on 09/04/16.
//  Copyright © 2016 Dennis Örnberg. All rights reserved.
//

import UIKit

protocol SearchDelegate: class {
    func changeTitle(title: String)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        delegate?.changeTitle(text)
        
        dismissViewControllerAnimated(true, completion: {})
    }
    
    
    
    // MARK: - Navigation
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: {})
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
        
        searchResult.append(keyword)
        
        let row = searchResult.indexOf(keyword)!
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    @IBAction func mostRecentButtonPressed(sender: UIButton) {
        delegate?.changeTitle("Most Recent")
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
