
//
//  ViewController.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/15/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBAction func onLoginBtnTouched(sender: AnyObject) {
        //TODO make this user.loginWithCompletion
        TwitterClient.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil{
                self.performSegueWithIdentifier("loginSeque", sender: self)
            }else{
                // handle login error
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

