//
//  UserSettingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sheng-Hua.Lin on 10/27/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class UserSettingViewController: UIViewController {

    @IBOutlet weak var usernameDisplay: UILabel!
    
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        
        prepareForSegue(UIStoryboardSegue(), sender: self)
            
        //println("print something!!!\(PFUser.currentUser())")
            
        performSegueWithIdentifier("logout", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameDisplay.text = PFUser.currentUser()?.username

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "logout"){
            var loginVC = segue.destinationViewController as! ViewController
            loginVC.loggedIn = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
