//
//  TweetsViewController.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/16/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets:[Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.homeTimelineWithParams(nil, completion: {(tweets, error) ->() in
            if let newTweets = tweets{
                self.tweets = newTweets
            }else{
                print("error: \(error?.description)")
            }
        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutTouch(sender: AnyObject) {
        User.logout()
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
