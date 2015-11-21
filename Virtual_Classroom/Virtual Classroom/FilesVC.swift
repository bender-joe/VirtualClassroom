//
//  FilesVC.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/21/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit
import Parse

class FilesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currentCourseID : String?
    var dummyFiles = ["Homework 1.docx","Homework 2.docx", "Chapter1_Slides.pdf", "Chapter2_Slides.pdf", "Chapter3_Slides.pdf",
    "Chapter4_Slides.pdf", "Chapter5_Slides.pdf", "Chapter6_Slides.pdf", "Chapter7_Slides.pdf"]

    @IBOutlet var filesTable: UITableView!
    var checked = [Bool]()
    var lastSelectedIndexPath : NSIndexPath?
    
    @IBAction func goBackButton(sender: AnyObject) {
        performSegueWithIdentifier("goBack", sender: currentCourseID)
    }
    
    func DisplayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func downloadButton(sender: AnyObject) {
        let fileSelection = dummyFiles[lastSelectedIndexPath!.row]
        DisplayAlert("Downloading File To Your Device",
            message: "\(fileSelection) is being downloaded.")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        filesTable.delegate = self
        filesTable.dataSource = self
        var i = 0
        while(i < dummyFiles.count){
            checked.append(false)
            i++;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goBack"){
            let courseViewController = segue.destinationViewController as! CourseViewController
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }

    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return dummyFiles.count

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.textLabel?.text = dummyFiles[indexPath.row]
        if checked[indexPath.row] == false {
            
            cell.accessoryType = .None
        }
        else if checked[indexPath.row] == true {
            
            cell.accessoryType = .Checkmark
        }
        return cell
    }
    
//     Function to help control the keyboard views
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//     function takes a text field and which must be there and returns boolean
    func textFieldShouldReturn(textField : UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetChecks()
    {
        for i in 0...filesTable.numberOfSections-1
        {
            for j in 0...filesTable.numberOfRowsInSection(i)-1
            {
                if let cell = filesTable.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: i)) {
                    cell.accessoryType = .None
                }
                
            }
        }
    }
    
}
