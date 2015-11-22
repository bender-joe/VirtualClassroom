//
//  LoginViewController.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 10/18/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    func DisplayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Function to Login and segue to the correct view if user is instructor or student
    @IBAction func login(sender: AnyObject) {
        //this is to attempt to solve a parse bug that occurs for the invalid session token error
        //PFUser.logOut()
            
        print(username.text)
        print(password.text)
        var userType = ""
        // Check if the input fields are empty.. display alert
        if username.text == "" || password.text == ""{
            DisplayAlert("Login Failed", message: "Please enter a username and password.")
        } else {
            // need to try to query
            let query = PFUser.query()
            // Var to hold the user type
            // query where the username is equal to the current user name that is trying to be logged in
            query!.whereKey("username", equalTo: self.username.text!)
            // method to get the objects from the query, return a PFObjects Array
            query!.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                // this query will always succeed because the login function checks for valid user names
                print("Successfully retrieved \(objects!.count) userType.")
                // Go get the usertype from the query
                let objects = objects as [PFObject]!
                // Objects is an Array of returned items... Should only have one!
                // I just wan to access the first element and get the userType
                userType = objects[0]["userType"] as! String
                print(userType)
            }

            PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                if error == nil && user != nil {
                    // logged in
                    // query the database to check the userType
                    
                    // if the user type is inst, go to the create course page
                    if(userType == "inst"){
                        self.performSegueWithIdentifier("login_inst", sender: self)
                    }
                    // If user is of type stud we need to segue over to the courses home page
                    if(userType == "stud"){
                        self.performSegueWithIdentifier("login_student", sender: self)
                    }
                } else {
                    var errorMessage = ""
                    if let errorString = error!.userInfo["error"] as? String{
                        errorMessage = errorString
                    }
                    self.DisplayAlert("Failed Login", message: errorMessage)
                }
            })
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
    @IBAction func register(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
