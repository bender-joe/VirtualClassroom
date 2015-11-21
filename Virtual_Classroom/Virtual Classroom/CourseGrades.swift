//
//  CourseGrades.swift
//  Virtual Classroom
//
//  Created by Miles Friedman on 11/20/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CourseGrades : UIViewController {
    
    @IBOutlet var navBarLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var titleString: String?
    var studentsGrades = ["Files", "Discussions"]
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navBarLabel.text = self.titleString
        getStudentGrades()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
        super.viewDidAppear(true)
    }
    
    func getStudentGrades () {
        //let courseParts = titleString?.characters.split(" ").map(String.init)
        let courseParts = titleString?.componentsSeparatedByString(" ")
        
        var prefix: String? = courseParts?[0]
        let number: String? = courseParts?[1]
        
        //For Debugging:
        //print(prefix! + " " + number!)
        
        //Query parse for the correct course and from that course, obtain the courseId
        let query = PFQuery(className: "Course")
        query.whereKey("coursePrefix", equalTo: prefix!)
        query.whereKey("courseNumber", equalTo: number!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                print(object)
                self.getCourseBasedOnId(object!)
                
            }//end if else
        
        }//end findFirstObjectInBackground
    }
    
    func getCourseBasedOnId (object: PFObject) {
        //get the course based on the courseId, then use that course to find each student and their grade
        let gradesQuery = PFQuery(className: "Grade")
        gradesQuery.whereKey("course", equalTo: object)
        //find all grades corresponding with that course
        gradesQuery.findObjectsInBackgroundWithBlock {
            (grades, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(grades!.count) grades.")
                
                // Do something with the found objects
                if let grades = grades {
                    
                    //for each grade, get the numeric grade and the corresponding student, then store as a string in the string array.
                    for grade in grades {
                        let score = grade["grade"].stringValue
                        let id = grade["User"].objectId
                        print(score)
                        print(id)
                        
                        self.fillStudentsGrades(score, id: id!)
                    }
                }
            }
            
        }//end findObjectsInBackround
    }
    
    func fillStudentsGrades (score: String, id: String!) {
        print("id: " + id)
        print("score: " + score)
        let studentQuery = PFUser.query()
        studentQuery!.whereKey("objectId", equalTo: id)
        studentQuery!.getFirstObjectInBackgroundWithBlock {
            (stud: PFObject?, error: NSError?) -> Void in
            print(stud)
            if error != nil || stud == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                let first = stud!.valueForKey("firstname") as! String!
                let last = stud!.valueForKey("lastname") as! String!
                print(first)
                print(last)
                print(score)
                self.studentsGrades.append(first + " " + last + ": " + score)
            }
        }
    }
    
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "instructorCourse")
        
        cell.textLabel?.text = self.studentsGrades[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.studentsGrades.count
    }
    
}