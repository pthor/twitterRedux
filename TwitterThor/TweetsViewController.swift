//
//  TweetsViewController.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/16/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets:[Tweet]?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180

        // Do any additional setup after loading the view.
        TwitterClient.homeTimelineWithParams(nil, completion: {(tweets, error) ->() in
            if let newTweets = tweets{
                self.tweets = newTweets
                self.tableView.reloadData()
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tweetCell = tableView.dequeueReusableCellWithIdentifier("BasicTweetTableViewCell", forIndexPath: indexPath) as UITableViewCell
 as! BasicTweetTableViewCell
        tweetCell.tweet = tweets![indexPath.row]
        return tweetCell
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
