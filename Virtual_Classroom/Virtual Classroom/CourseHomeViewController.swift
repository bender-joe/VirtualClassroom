//
//  CourseHomeViewController.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 10/4/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit
import Parse

class CourseHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var coursesTable: UITableView!
    var userEnrolledCourses = [String]()
    var userEnrolledCourseIDs = [String]()
    var coursesTest = ["Testing"]

    @IBAction func logoutButton(sender: AnyObject) {
        var user = PFUser.currentUser()
        print("logging out user \(user)")
        PFUser.logOut()
        user = PFUser.currentUser()
        print("trying to logout user")
        if(user == nil){
            print("\(user) is now logged out... going back to login screen")
            performSegueWithIdentifier("logout", sender: nil)
        }
    }
    let user = PFUser.currentUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coursesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        coursesTable.delegate = self
        coursesTable.dataSource = self
        // Do any additional setup after loading the view
        // need to query the DB to get the courses the user is enrolled in
        var query = PFQuery(className: "Enrolled_In")
        // want to get the rows from the table that correspond to the current user
        query.whereKey("User", equalTo: user!)
        // also want to get the data associated with the pointer column to courses
        query.includeKey("Course")
        
        // go and get the results of the query
        query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            // get the courses from enrolled_in
            if let courses = objects {
                // loop through the objects array in the result
                for object in courses {
                    if let course = object["Course"] as? PFObject{  // get the course pointer from Course column in Enrolled_In
                        let coursePref = course["coursePrefix"] as? String      // get course prefix
                        let courseNumber = course["courseNumber"] as? String    // get course number
                        let courseName = course["courseName"] as? String        // get course name
                        let courseID = course.objectId                          // get course ID
                        print(courseName)
                        self.userEnrolledCourseIDs.append(courseID!)            // put in the array
                        self.userEnrolledCourses.append(""+coursePref!+""+courseNumber!+" "+courseName!)// put the
                    }
                }
            self.coursesTable.reloadData()
            }
        })
    }
        
    
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(courseIDs[indexPath.row])
//        
//        }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return userEnrolledCourses.count
        //comment
    
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = userEnrolledCourses[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
