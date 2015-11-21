//
//  NewDiscussionVC.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/21/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Parse
import UIKit

class NewDiscussionVC: UIViewController {
    var currentCourseID : String?
    
    @IBOutlet var discussionTitle: UITextField!
    
    @IBOutlet var discussionPostContent: UITextView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBAction func goBackButton(sender: AnyObject) {
        performSegueWithIdentifier("goBack", sender: currentCourseID)
    }
    
    @IBAction func createDiscussionButton(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goBack"){
            let courseViewController = segue.destinationViewController as! DiscussionsHomeVC
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
//        if(segue.identifier == "newDiscussion"){
//            let courseViewController = segue.destinationViewController as! NewDiscussionVC
//            let currentCourseID = sender as! String
//            courseViewController.currentCourseID = currentCourseID
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
