/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var loggedIn = false
    
    var signUpActive = true

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var login_signUp_button: UIButton!
    
    @IBOutlet weak var switchMode_button: UIButton!
    
    @IBOutlet weak var signUpDescription: UILabel!
    
    @IBOutlet weak var signUpDescription2: UILabel!
    
    var activitiyIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func login_SignUp(sender: AnyObject) {
        
            
        if usernameText.text == "" || passwordText.text == "" {
            displayAlert("Error In Field", message: "Please enter a username and password")
        } else {
            
            if signUpActive == true {
            
                activitiyIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                activitiyIndicator.center = self.view.center
                activitiyIndicator.hidesWhenStopped = true
                activitiyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                view.addSubview(activitiyIndicator)
                activitiyIndicator.startAnimating()
                
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                
                var user = PFUser()
                user.username = usernameText.text
                user.password = passwordText.text
                
                var errorMsg = "Please Try Again Later"
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activitiyIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                    if error == nil {
                        
                        //sign up successful
                        self.performSegueWithIdentifier("login", sender: self)
                        self.zloggedIn = true
                        
                    } else {
                        if let errorString = error!.userInfo?["error"] as? String {
                            errorMsg = errorString
                        }
                            self.displayAlert("Failed Sign up", message: errorMsg)
                    }
                })
                
            } else {
                
                activitiyIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                activitiyIndicator.center = self.view.center
                activitiyIndicator.hidesWhenStopped = true
                activitiyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                view.addSubview(activitiyIndicator)
                activitiyIndicator.startAnimating()
                
                PFUser.logInWithUsernameInBackground(usernameText.text, password: passwordText.text, block: { (user, error) -> Void in
                    
                    self.activitiyIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        //logged in
                        self.performSegueWithIdentifier("login", sender: self)
                        self.loggedIn = true
                        
                    } else {
                        var errorMsg = "Login failed"
                        if let errorString = error!.userInfo?["error"] as? String {
                            errorMsg = errorString
                        }
                        self.displayAlert("Failed Login", message: errorMsg)
                    }
                })
                
            }
        }

    }
    
    @IBAction func switchMode(sender: AnyObject) {
        
        if (signUpActive == true) {
            
            login_signUp_button.setTitle("Login", forState: UIControlState.Normal)
            switchMode_button.setTitle("Sign Up", forState: UIControlState.Normal)
            signUpDescription.text = "Not Registered?"
            signUpDescription2.text = "Login Below!"
            signUpActive = false
            
        } else {
            
            login_signUp_button.setTitle("Sign Up", forState: UIControlState.Normal)
            switchMode_button.setTitle("Login", forState: UIControlState.Normal)
            signUpDescription.text = "Already Registered?"
            signUpDescription2.text = "Sign Up Below!"
            signUpActive = true
            
        }
        
    }

    
    
    func displayAlert(title:String, message:String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if loggedIn == true {
            
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
