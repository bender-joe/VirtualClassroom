//
//  RegisterViewController.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 10/18/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Parse
import UIKit

//struct myGlobals {
    //var associatedCourses: [String] = ["test"]
//}

class InstViewController : UIViewController, UITextFieldDelegate {
    
    var assocCourses: [String] = []
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        getAssociatedCourses()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableViewOutlet.reloadData()
        super.viewDidAppear(true)
    }
    
    func getAssociatedCourses () {
        
        //query parse for courses that the logged in instructor is enrolled in
        let user = PFUser.currentUser()
        let query = PFQuery(className:"Enrolled_In")
        query.whereKey("User", equalTo: user!)
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            
            if error == nil {
                
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) courses.")
                
                // Do something with the found objects
                if let objects = objects! as? [PFObject] {
                    
                    for object in objects {
                        print(object.objectId)
                        
                        //retrieve the corresponding courseId for each object
                        var tempID = object["Course"].objectId as String!
                        print(tempID)
                        
                        //create a query that grabs the course information from the course table using the tempID
                        var courseQuery = PFQuery(className: "Course")
                        courseQuery.getObjectInBackgroundWithId(tempID) {
                            (singleCourse: PFObject?, error: NSError?) -> Void in
                            
                            if error == nil && singleCourse != nil {
                                print(singleCourse)
                                let coursePrefix = singleCourse?.valueForKey("coursePrefix") as! String
                                let courseNumber = singleCourse?.valueForKey("courseNumber") as! String
                                print(coursePrefix, courseNumber)
                                self.assocCourses.append(coursePrefix + courseNumber)
                                print(self.assocCourses)
                                //self.tableView.reloadData()
                            } else {
                                print("Error retrieving singleCourse")
                            }
                        }
                    }
                    
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        
        }
        
        
        //Log the contents of associated courses
        print(self.assocCourses)
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.assocCourses.count
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "instructorCourse")
        
        //getAssociatedCourses()
        
        cell.textLabel?.text = self.assocCourses[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}