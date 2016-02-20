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
    @IBOutlet weak var tweetDetailView: TweetDetailView!
    @IBOutlet weak var tweetContainerView: TweetDetailContainerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getLatestTweets", name: userDidTweetNotification, object: nil)
        customizeNavbar()
        configTableView()

    }
    
    override func viewWillAppear(animated: Bool) {
        getLatestTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configTableView(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180
    }
    
    @IBAction func tapOut(sender: AnyObject) {
        let tapPoint = sender.locationInView(tweetContainerView)
        if (tapPoint.y < 0 || tapPoint.y > tweetContainerView.frame.height){
            tweetDetailView.fadeOut()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("show tweet")
        tweetDetailView.alpha = 0
        tweetDetailView.hidden = false
        tweetDetailView.tweet = tweets![indexPath.row]
        tweetDetailView.fadeIn(duration: NSTimeInterval(0.5))
        
    }
    
    @IBAction func onLogoutTouch(sender: AnyObject) {
        User.logout()
    }
    
    func customizeNavbar(){
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Default
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "Twitter_logo_white_32")
        navigationItem.titleView = imageView
    }
    
    
    func getLatestTweets(){
        print("get latest")
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tweetCell = tableView.dequeueReusableCellWithIdentifier("BasicTweetTableViewCell", forIndexPath: indexPath) as UITableViewCell
 as! BasicTweetTableViewCell
        tweetCell.tweet = tweets![indexPath.row]
        return tweetCell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        getLatestTweets()
        refreshControl.endRefreshing()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/


}
