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
    
    var dummyDiscussions = ["Question for Homework 2"]
    
    @IBOutlet var discussionTable: UITableView!
    
    @IBAction func newDiscussionButton(sender: AnyObject) {
        
        
        performSegueWithIdentifier("newDiscussion", sender: currentCourseID)
    }
    
    
    @IBAction func goBackButton(sender: AnyObject) {
        performSegueWithIdentifier("goBack", sender: currentCourseID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.discussionTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        discussionTable.delegate = self
        discussionTable.dataSource = self
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return dummyDiscussions.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goBack"){
            let courseViewController = segue.destinationViewController as! CourseViewController
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
        if(segue.identifier == "newDiscussion"){
            let courseViewController = segue.destinationViewController as! NewDiscussionVC
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
        if(segue.identifier == "showDiscussion"){
            let courseViewController = segue.destinationViewController as! DiscussionVC
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
    }
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        //
                cell.textLabel?.text = dummyDiscussions[indexPath.row]
                cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    // This is used when the user selects a discussion... need to perform a segue to the discussion page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("User going to view discussion \(dummyDiscussions[indexPath.row])")
//        let discussionTitle = dummyDiscussions[indexPath.row]
        performSegueWithIdentifier("showDiscussion", sender: currentCourseID)
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
