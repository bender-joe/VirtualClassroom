//
//  LoginViewController.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 10/18/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: ViewController {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    func DisplayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func login(sender: AnyObject) {
        if username.text == "" || password.text == ""{
            DisplayAlert("Login Failed", message: "Please enter a username and password.")
        } else {

            
            PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                if user != nil {
                    // logged in
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
    
    
    @IBAction func register(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
