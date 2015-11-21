//
//  DiscussionsHomeVC.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/21/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Parse
import UIKit

class DiscussionsHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currentCourseID : String?
    @IBAction func goBackButton(sender: AnyObject) {
        performSegueWithIdentifier("goBack", sender: currentCourseID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goBack"){
            let courseViewController = segue.destinationViewController as! CourseViewController
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
//        if(segue.identifier == "coursediscussions"){
//            let courseViewController = segue.destinationViewController as! DiscussionsHomeVC
//            let currentCourseID = sender as! String
//            courseViewController.currentCourseID = currentCourseID
//        }
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
