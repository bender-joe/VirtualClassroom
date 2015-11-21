//
//  FilesVC.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/21/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit
import Parse

class FilesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return 1
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        //
//        cell.textLabel?.text = courseFuncts[indexPath.row]
//        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    // Function to help control the keyboard views
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        self.view.endEditing(true)
//    }
    
    // function takes a text field and which must be there and returns boolean
//    func textFieldShouldReturn(textField : UITextField) -> Bool {
//        
//        textField.resignFirstResponder()
//        
//        return true
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
