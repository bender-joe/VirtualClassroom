//
//  CreateCourse.swift
//  Virtual Classroom
//
//  Created by Miles Friedman on 11/20/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CreateCourse: UIViewController {
    
    @IBOutlet var coursePrefix: UITextField!
    @IBOutlet var courseNumber: UITextField!
    @IBOutlet var courseStartTime: UITextField!
    @IBOutlet var courseEndTime: UITextField!
    @IBOutlet var courseDays: UITextField!
    
    
    @IBAction func createCourse(sender: AnyObject) {
        
        let coursePre = coursePrefix.text!
        let courseNum = courseNumber.text!
        let startTime = courseStartTime.text!
        let endTime = courseEndTime.text!
        let days = courseDays.text!
        
        //error check here to make sure the course doesn't already exist by querying the parse
        
        
        
        //add the newly created course to the courses table
        let newCourse = PFObject(className: "Course")
        newCourse["coursePrefix"] = coursePre
        newCourse["courseNumber"] = courseNum
        //for now only add what columns are already in the table
        newCourse.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("The new course has been saved")
                self.fillEnrolledTable()
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    func fillEnrolledTable () {
        
        //query for that newly added class to get the courseId
        let query = PFQuery(className: "Course")
        query.whereKey("coursePrefix", equalTo: coursePrefix.text!)
        query.whereKey("courseNumber", equalTo: courseNumber.text!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                
                //get the object id of the successfully retrieved object
                let courseId = object?.objectId
                print(courseId)
                
                //add a row to the enrolled table that enrolls the logged in instructor into that course
                let enrolling = PFObject(className: "Enrolled_In")
                enrolling["User"] = PFUser.currentUser()
                enrolling["Course"] = PFObject(withoutDataWithClassName: "Course", objectId: courseId)
                enrolling.saveInBackground()
                
                //segue the user back to the previous page
                self.performSegueWithIdentifier("inst_courses_home", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}