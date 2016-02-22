//
//  ComposeView.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/18/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetMessageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetMessageTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Top
        
        let user = User.currentUser
        
        if(user != nil ){
            userFullNameLabel.text = user!.name
            userNameLabel.text = user!.screenname
            if (user!.profileImageUrl != nil){
                let avatarImage = NSURL(string: user!.profileImageUrl!)
                if avatarImage != nil{
                    userProfileImage.setImageWithURL(avatarImage!)
                }
            }
        }

    
    }
    
    @IBAction func cacelComposePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }

    @IBAction func onTweetButtonPressed(sender: AnyObject) {
        if(tweetMessageTextField.text != nil && tweetMessageTextField.text! > ""){
            User.postTweet(tweetMessageTextField.text!)
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            print("There was no text to tweet so im not tweeting that")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
