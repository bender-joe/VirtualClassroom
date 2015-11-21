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
    var currentCourseID : String?
    var currentCourseName : String?
    
    
    // course functionalities to display as table cells
    let courseFuncts = ["Discussions", "Files"]

    // UI Elements
    @IBOutlet var coureTitleField: UINavigationItem!
    
    @IBOutlet var courseGrade: UILabel!
    
    @IBOutlet var courseOptionsTable: UITableView!
    
    // Here I need to query and get the course name... currentCourseID is populated in the segue from CoursesHome
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.currentUser()
        self.courseOptionsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        courseOptionsTable.delegate = self
        courseOptionsTable.dataSource = self
        // Query the Course Table to get the name to display as the title
        if (self.currentCourseID != nil) {
        let query = PFQuery(className: "Course")
        query.whereKey("objectId", equalTo: self.currentCourseID!)
        query.findObjectsInBackgroundWithBlock ({ (resultObjects:[PFObject]?,error: NSError?) -> Void in
            // if there are results
            if let course = resultObjects {
                // loop through the results
                for resultObject in course {
                    let coursePref = resultObject["coursePrefix"] as? String      // get course prefix
                    let courseNumber = resultObject["courseNumber"] as? String    // get course number
                    self.currentCourseName = "\(coursePref) \(courseNumber)"
                    print("\(coursePref) \(courseNumber)")
                    // put "prefix number" as title field text
                    self.coureTitleField.title = "\(coursePref!) \(courseNumber!)"
                
                }
            }
        })// end query
        
        // now query the Grade table to get this student's grade in the course to display at the top
        let query2 = PFQuery(className: "Grade")
        query2.whereKey("User", equalTo: currentUser!)
        let coursePointer = PFObject(withoutDataWithClassName: "Course", objectId: self.currentCourseID)
        query2.whereKey("course", equalTo: coursePointer)
        
        // now get the results from the query2
        query2.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            // get the courses from enrolled_in
            if let grades = objects {
                // loop through the objects array in the result
                for object in grades {
                    
                    let grade = object["grade"] as! Double
                    var studentGrade = grade.description
                    studentGrade += "%"
                    print("Got the student's grade for the course as: "+studentGrade)
                    self.courseGrade.text! = studentGrade
                    
                }
            }
        })
        }
        self.courseOptionsTable.reloadData()
        
        
    }
    
    @IBAction func goBackButton(sender: AnyObject) {
        currentCourseID = ""
        currentCourseName = ""
    }
    
    // This is used when the user selects a course funct... need to perform a segue to the course page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("User going to view functionality \(courseFuncts[indexPath.row])")
        let userSelection = courseFuncts[indexPath.row]
        
        if(userSelection == "Files"){
            performSegueWithIdentifier("coursefiles", sender: currentCourseID)
        }
        if(userSelection == "Discussions"){
            performSegueWithIdentifier("coursediscussions", sender: currentCourseID)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "coursefiles"){
            let courseViewController = segue.destinationViewController as! FilesVC
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
        if(segue.identifier == "coursediscussions"){
            let courseViewController = segue.destinationViewController as! DiscussionsHomeVC
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return courseFuncts.count
//        //comments
        
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
//
        cell.textLabel?.text = courseFuncts[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}