//
//  NewCommentVC.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/21/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit
import Parse

class NewCommentVC: UIViewController {
    var currentCourseID : String?
    var discTitle : String?
    var discPosts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        discussionTitle.text = discTitle
    }
    
    @IBOutlet var discussionTitle: UILabel!
    
    @IBOutlet var newCommentContent: UITextView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBAction func goBackButton(sender: AnyObject) {
        performSegueWithIdentifier("goBack", sender: currentCourseID)
    }
    
    @IBAction func postCommentButton(sender: AnyObject) {
        discPosts.append(newCommentContent.text)
        performSegueWithIdentifier("newReply", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goBack"){
            let discussion = segue.destinationViewController as! DiscussionVC
            let currentCourseID = self.currentCourseID
            let title = self.discussionTitle.text!
            let posts = self.discPosts
            discussion.currentCourseID = currentCourseID
            discussion.dummydiscussionPosts = posts
            discussion.discTitle = title
        }
        if(segue.identifier == "newReply"){
            let discussion = segue.destinationViewController as! DiscussionVC
            let currentCourseID = self.currentCourseID
            let title = self.discussionTitle.text!
            let posts = self.discPosts
            discussion.currentCourseID = currentCourseID
            discussion.dummydiscussionPosts = posts
            discussion.discTitle = title
        }
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
