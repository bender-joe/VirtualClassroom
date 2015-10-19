//
//  RegisterViewController.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 10/18/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import Parse
import UIKit


class RegisterViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var school: UITextField!
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var emailValidate: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    func containsInt(password: String, confirmPassword : String) -> Bool{
        if (password.rangeOfString("1") != nil || confirmPassword.rangeOfString("1") != nil){
            return true
        }
        else if (password.rangeOfString("2") != nil || confirmPassword.rangeOfString("2") != nil){
            return true
        }
        else if (password.rangeOfString("3") != nil || confirmPassword.rangeOfString("3") != nil){
            return true
        }
        else if (password.rangeOfString("4") != nil || confirmPassword.rangeOfString("4") != nil){
            return true
        }
        else if (password.rangeOfString("5") != nil || confirmPassword.rangeOfString("5") != nil){
            return true
        }
        else if (password.rangeOfString("6") != nil || confirmPassword.rangeOfString("6") != nil){
            return true
        }
        else if (password.rangeOfString("7") != nil || confirmPassword.rangeOfString("7") != nil){
            return true
        }
        else if (password.rangeOfString("8") != nil || confirmPassword.rangeOfString("8") != nil){
            return true
        }
        else if (password.rangeOfString("9") != nil || confirmPassword.rangeOfString("9") != nil){
            return true
        }
        else if (password.rangeOfString("0") != nil || confirmPassword.rangeOfString("0") != nil){
            return true
        }
        else {
            return false;
        }
    }
    
    func validateFields() -> String{
        
        if(firstName.text! == "" ||
        lastName.text! == "" ||
        school.text! == "" ||
        emailAddress.text! == "" ||
        emailValidate.text! == "" ||
        password.text! == "" ||
            confirmPassword.text  == ""){
                return "All fields must be complete. Please try again."
        } else if( emailAddress.text! != emailValidate.text!) {
            
            return "Email addresses do not match. Please try again."
    
        } else if( password.text! != confirmPassword.text!){
            return "Passwords do not match. Please try again."
        } else if( password.text!.characters.count < 8 || confirmPassword.text!.characters.count < 8 ){
            return "Password must be at least 8 characters"
        } else if ( !containsInt(password.text!, confirmPassword: confirmPassword.text!) ){
            return "Password must contain an integer."
        }
        else {
            return ""
        }
    }
    
    
    @IBAction func CreateAccount(sender: AnyObject) {
        
        var errorMessage : String
        errorMessage = validateFields();
        
        if errorMessage != "" {
            displayAlert("Error", message: errorMessage)
        } else{
            errorMessage = "Please Try Again"
            // got good input here lets create the user
            var user = PFUser()
            user.username = emailAddress.text
            user.password = password.text
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                if error == nil {
                    // sign up successful
                } else {
                    
                    // trying to get the error message from error
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        errorMessage = errorString
                    }
                    self.displayAlert("Failed to Create Account", message: errorMessage)
                }
            })
            
        }
    }
    
    // Function to help control the keyboard views
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    // function takes a text field and which must be there and returns boolean
    func textFieldSHouldReturn(textField : UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.firstName.delegate = self // the view controller is responsible for the text field
        self.lastName.delegate = self // the view controller is responsible for the text field
        self.school.delegate = self // the view controller is responsible for the text field
        self.emailAddress.delegate = self // the view controller is responsible for the text field
        self.emailValidate.delegate = self // the view controller is responsible for the text field
        self.password.delegate = self // the view controller is responsible for the text field
        self.confirmPassword.delegate = self // the view controller is responsible for the text field


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
