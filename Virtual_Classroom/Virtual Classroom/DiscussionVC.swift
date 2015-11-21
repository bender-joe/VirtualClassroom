//
//  DiscussionVC.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 11/21/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Parse
import UIKit

class DiscussionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dummydiscussionPosts = ["I don't understand what this question is asking. What should I put for the answer"]
    var currentCourseID : String?

    @IBOutlet var discussionTitle: UINavigationItem!
    
    
    @IBOutlet var commentsTable: UITableView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBAction func goBackButton(sender: AnyObject) {
        performSegueWithIdentifier("goBack", sender: currentCourseID)
    }
    
        
    @IBAction func newPostButton(sender: AnyObject) {
        performSegueWithIdentifier("newComment", sender: currentCourseID)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goBack"){
            let courseViewController = segue.destinationViewController as! DiscussionsHomeVC
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
        if(segue.identifier == "newComment"){
            let courseViewController = segue.destinationViewController as! NewCommentVC
            let currentCourseID = sender as! String
            courseViewController.currentCourseID = currentCourseID
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentsTable.rowHeight = UITableViewAutomaticDimension
        commentsTable.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return dummydiscussionPosts.count
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        //
                cell.textLabel?.text = dummydiscussionPosts[indexPath.row]
        //        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
