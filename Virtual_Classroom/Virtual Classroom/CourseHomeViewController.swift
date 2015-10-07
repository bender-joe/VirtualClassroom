//
//  CourseHomeViewController.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 10/4/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit

class CourseHomeViewController: UIViewController, UITableViewDelegate {

    var courseExamples = ["COP4710 Database Systems", "COP4331c Processes for OO", "EEL4742C Embedded Systems"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int
    {
        return courseExamples.count
    
    }
    // This function will need DB calls to get the courses for the user, and load their information

    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = courseExamples[indexPath.row]
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
