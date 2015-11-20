//
//  CourseViewController.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/19/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Parse
import UIKit

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // This is used when the user selects a course... need to perform a segue to the course page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("User going to view course \(userEnrolledCourseIDs[indexPath.row])")
        
        
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return 1
//        //comment
        
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
//
//        cell.textLabel?.text = userEnrolledCourses[indexPath.row]
//        cell.accessoryType = .DisclosureIndicator
        return cell
    }

    // Function to help control the keyboard views
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    // function takes a text field and which must be there and returns boolean
    func textFieldShouldReturn(textField : UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}