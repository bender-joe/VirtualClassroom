//
//  SearchVC.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/18/15.
//  Copyright © 2015 Vlass. All rights reserved.
//
import UIKit
import Parse

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var resultsTable: UITableView!
    @IBOutlet var courseNum: UITextField!
    @IBOutlet var coursePrefix: UITextField!
    
    var courseExamples = ["COP4710 Database Systems", "COP4331c Processes for OO", "EEL4742C Embedded Systems"]
    // Create the search results array
    var searchResults = [String]()
    var courseIDs = [""]
    var checked = [Bool]()
    var lastSelectedIndexPath : NSIndexPath?
    
    @IBAction func searchCourses(sender: AnyObject) {
        // get the strings of the user input
        searchResults.removeAll()
        courseIDs.removeAll()
        
        // reset checks
//        resetChecks()
        let number = courseNum.text!
        let prefix = coursePrefix.text!
        
        // search by course number - query course table for number
        if(number != ""){
            var query = PFQuery(className:"Course")
            query.whereKey("courseNumber", equalTo: number)
            query.findObjectsInBackgroundWithBlock {
                (objects, error) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject]! {
                        for course in objects {
                            var result = course["coursePrefix"] as! String
                            result += " "
                            result.appendContentsOf(course["courseNumber"] as! String)
                            result += " "
                            result.appendContentsOf(course["courseName"] as! String)
                            print(result)
                            self.searchResults.append(result)
                            self.courseIDs.append(course.objectId!)
                            self.checked.append(false)
                            print(self.searchResults[0])
                        }
                    }
                    // reload the table view data
                    self.resultsTable.reloadData()
                    //After reloading we need to clear out the array...
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }// end query block
        }
        
        // Search by prefix
        if(prefix != ""){
            var query = PFQuery(className:"Course")
            query.whereKey("coursePrefix", equalTo: prefix)
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject]! {
                        for object in objects {
                            var result = object["coursePrefix"] as! String
                            result += " "
                            result.appendContentsOf(object["courseNumber"] as! String)
                            result += " "
                            result.appendContentsOf(object["courseName"] as! String)
                            print(result)
                            self.searchResults.append(result)
                            self.checked.append(false)
                            self.courseIDs.append(object.objectId!)
                            print(self.searchResults[0])
                        }
                    }
                    // reload the table view data
                    self.resultsTable.reloadData()
                    //After reloading we need to clear out the array...
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }// end query block
        }
    }// end search button
    
    // ENROLL BUTTON
    @IBAction func EnrollButton(sender: AnyObject) {
        // get the selected courses in the table
        if(lastSelectedIndexPath != nil){
            let selectedCourseID = courseIDs[(lastSelectedIndexPath?.row)!]
            // query and add them to the DB for the user
            let enrolling = PFObject(className: "Enrolled_In")
            
            print("enrolling "+(PFUser.currentUser()?.objectId)!+" "+selectedCourseID)
            // before insert into enrolling check if student is enrolled
            var query = PFQuery(className: "Enrolled_In")
            query.whereKey("User", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("Course", equalTo: selectedCourseID)
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects
                // check enrolled_in and see if they are enrolled in the DB...
            })
            
            
            enrolling["User"] = PFUser.currentUser()
            enrolling["Course"] = PFObject(withoutDataWithClassName: "Course", objectId: selectedCourseID)
            enrolling.saveInBackground()
//            performSegueWithIdentifier("done_enrolling", sender: nil)
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            print(courseIDs[indexPath.row])
        
        // Code for checkmarks
        if indexPath.row != lastSelectedIndexPath?.row {
            if let lastSelectedIndexPath = lastSelectedIndexPath {
                let oldCell = tableView.cellForRowAtIndexPath(lastSelectedIndexPath)
                oldCell?.accessoryType = .None
            }
            
            let newCell = tableView.cellForRowAtIndexPath(indexPath)
            newCell?.accessoryType = .Checkmark
            
            lastSelectedIndexPath = indexPath
        }
//        let indexPath = resultsTable.indexPathForSelectedRow!
//        
//        let currentCell = resultsTable.cellForRowAtIndexPath(indexPath)
//        
//        print(currentCell!.textLabel!.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        resultsTable.delegate = self
        resultsTable.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        
        return 1
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return searchResults.count
        //comment
        
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = self.searchResults[indexPath.row]
        if checked[indexPath.row] == false {
            
            cell.accessoryType = .None
        }
        else if checked[indexPath.row] == true {
            
            cell.accessoryType = .Checkmark
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func resetChecks()
    {
        for i in 0...resultsTable.numberOfSections-1
        {
            for j in 0...resultsTable.numberOfRowsInSection(i)-1
            {
                if let cell = resultsTable.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: i)) {
                    cell.accessoryType = .None
                }
                
            }
        }
    }
    
}