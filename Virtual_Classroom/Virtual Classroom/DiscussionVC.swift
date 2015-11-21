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
    var dummydiscussionPosts = [String]()
    var currentCourseID : String?
    var discTitle : String?

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
            let discHome = segue.destinationViewController as! DiscussionsHomeVC
            let currentCourseID = sender as! String
            discHome.currentCourseID = currentCourseID
        }
        if(segue.identifier == "newComment"){
            let newComment = segue.destinationViewController as! NewCommentVC
            let currentCourseID = self.currentCourseID
            let title = self.discTitle
            let posts = self.dummydiscussionPosts
            newComment.currentCourseID = currentCourseID
            newComment.discTitle = title
            newComment.discPosts = posts
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentsTable.rowHeight = UITableViewAutomaticDimension
        commentsTable.estimatedRowHeight = UITableViewAutomaticDimension
        discussionTitle.title = discTitle
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 200.0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return dummydiscussionPosts.count
    }
    
    // This function will need DB calls to get the courses for the user, and load their information
    func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        return basicCellAtIndexPath(indexPath)
        //
//                cell.textLabel?.text = dummydiscussionPosts[indexPath.row]
        //        cell.accessoryType = .DisclosureIndicator
//        return cell
    }
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> DiscussionCell {
        let cell = commentsTable.dequeueReusableCellWithIdentifier("DiscussionCell") as! DiscussionCell
        setTitleForCell(cell, indexPath: indexPath)
        return cell
    }
    func setTitleForCell(cell:DiscussionCell, indexPath:NSIndexPath) {
        cell.titleLabel.text = dummydiscussionPosts[indexPath.row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
