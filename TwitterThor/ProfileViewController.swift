//
//  BlueViewController.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/25/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        setupRefreshControl()
        getUsersStatus()
        //let headerNib = UINib(nibName: "TableViewHeaderFooterView", bundle: nil)
        //self.tableView.registerNib(headerNib, forHeaderFooterViewReuseIdentifier: "TableViewHeaderFooterView")
        
        //self.tableView.registerClass(ProfileDetailsTableViewCell.self, forHeaderFooterViewReuseIdentifier: "ProfileDetailsTableViewCell")
        let user = User.currentUser
        if (user!.profile_banner_url != nil){
            let avatarImage = NSURL(string: user!.profile_banner_url!)
            if avatarImage != nil{
                print("set header image")
                bannerBackgroundImageView.setImageWithURL(avatarImage!)
            }
        }
    }
    
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @IBOutlet weak var bannerBackgroundImageView: UIImageView!
    
    var tweets: [Tweet] = [Tweet]()
    var bannerImageView: UIImageView = UIImageView()
    
    var profileCell:ProfileDetailsTableViewCell!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configTableView(){
        tableView.backgroundColor = UIColor.clearColor()
//        let refreshControl = UIRefreshControl()
//        
//        if let bannerUrl = User.currentUser?.profile_banner_url{
//            print("~~~~~~bannerUrl \(bannerUrl)")
//            let bannerImageUrl = NSURL(string: bannerUrl)
//            if bannerImageUrl != nil {
//                 print("~~~~~~ad this as refresh subview \(bannerImageUrl)")
//                bannerImageView.setImageWithURL(bannerImageUrl!)
//                refreshControl.insertSubview(bannerImageView, atIndex: 0)
//            }
//        }
//        
//        
//        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
//
//        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180
    }
    
    func customizeNavbar(){
        if let navigationBar = self.navigationController?.navigationBar{
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            navigationBar.shadowImage = UIImage()
            navigationBar.translucent = true
        }
    }
    
    func getUsersStatus(){
        User.currentUser!.statuses({(tweets, error) ->() in
            if let newTweets = tweets{
                self.tweets = newTweets
                self.tableView.reloadData()
            }else{
                print("error: \(error?.description)")
            }
        })
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0 ){
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderTableViewCell", forIndexPath: indexPath) as! ProfileHeaderTableViewCell
            cell.contentView.backgroundColor = UIColor.clearColor()
            cell.backgroundView?.backgroundColor = UIColor.clearColor()
//            let backgroundView = UIView()
//            backgroundView.backgroundColor = UIColor.clearColor()
//            cell.backgroundView = backgroundView


            return cell
        }else 
        if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileDetailsTableViewCell", forIndexPath: indexPath) as! ProfileDetailsTableViewCell
            profileCell = cell
            cell.user = User.currentUser
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("BasicTweetTableViewCell", forIndexPath: indexPath) as UITableViewCell
                as! BasicTweetTableViewCell
            //TODO this would be better managed by having table sections
            cell.tweet = tweets[indexPath.row - 1]
            return cell
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count + 1
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0){
            cell.backgroundColor = UIColor.clearColor()
        }
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableViewHeaderFooterView")
//
//        return header
//    }
//
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        getUsersStatus()
        refreshControl.endRefreshing()
    }
    
    
    
    
    
    var refreshControl: UIRefreshControl!
    var refreshLoadingView : UIView!
    var refreshColorView : UIView!
    var compass_background : UIImageView!
    var compass_spinner : UIImageView!
    
    var isRefreshIconsOverlap = false
    var isRefreshAnimating = false
    
    func setupRefreshControl() {
        
        // Programmatically inserting a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        
        // Setup the loading view, which will hold the moving graphics
        refreshLoadingView = UIView(frame: self.refreshControl!.bounds)
        refreshLoadingView.backgroundColor = UIColor.clearColor()
        
        // Setup the color view, which will display the rainbowed background
        self.refreshColorView = UIView(frame: self.refreshControl!.bounds)
        self.refreshColorView.backgroundColor = UIColor.clearColor()
        self.refreshColorView.alpha = 0.30
        
        // Create the graphic image views
        compass_background = UIImageView(image: UIImage(named: "compass_background"))
        self.compass_spinner = UIImageView(image: UIImage(named: "compass_spinner"))
        
        // Add the graphics to the loading view
        //self.refreshLoadingView.addSubview(self.compass_background)
        //self.refreshLoadingView.addSubview(self.compass_spinner)
        
        // Clip so the graphics don't stick out
        //self.refreshLoadingView.clipsToBounds = true;
        
        // Hide the original spinner icon
        //self.refreshControl!.tintColor = UIColor.clearColor()
        
        // Add the loading and colors views to our refresh control
        //self.refreshControl!.addSubview(self.refreshColorView)
        //self.refreshControl!.addSubview(self.refreshLoadingView)
        
        // Initalize flags
        self.isRefreshIconsOverlap = false;
        self.isRefreshAnimating = false;
        
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // When activated, invoke our refresh function
        refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh(){
        
        User.currentUser!.statuses({(tweets, error) ->() in
            if let newTweets = tweets{
                self.tweets = newTweets
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()
                //self.resetAnimation()
            }else{
                print("error: \(error?.description)")
            }
        })
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
        self.blurEffectView.alpha = 0
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        print("scrollViewDidEndZooming")
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        print("scrollViewDidScrollToTop")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
         print("scrollViewDidEndDecelerating")
        //self.blurEffectView.alpha = 0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // Get the current size of the refresh controller
        var refreshBounds = self.refreshControl!.bounds;
        
        // Distance the table has been pulled >= 0
        //let pullDistance = max(0.0, -self.refreshControl!.frame.origin.y);
        let pullDistance = -self.refreshControl!.frame.origin.y

        // Calculate the pull ratio, between 0.0-1.0
        let pullRatio = min( max(pullDistance, 0.0), 100.0) / 100.0;
        
        if pullDistance > 20{
            self.blurEffectView.alpha = pullRatio
        }else{
            self.blurEffectView.alpha = 0
        }
        
        let userHeaderHeight = pullDistance + 270
        self.bannerBackgroundImageView.frame = CGRectMake(0 , 0, self.view.frame.width, userHeaderHeight)
        
        // Set the encompassing view's frames
        
            //refreshBounds.size.height = pullDistance;
       
        
        // If we're refreshing and the animation is not playing, then play the animation
//        if (pullDistance > 10 && !self.isRefreshAnimating) {
//            self.animateRefreshView()
//            //self.resetAnimation()
//        }else
        
            //TODO this is wack
//        if(pullDistance <= 0 && self.isRefreshAnimating){
//            print("setAnimationBecause pullDistance <= 0")
//            resetAnimation()
//        }
        
        print("pullDistance \(pullDistance), pullRatio: \(pullRatio), midX: (midX), refreshing: \(self.refreshControl!.refreshing)")
    }
    
//    func animateRefreshView() {
//        
//        print("animateRefreshView")
//        // Flag that we are animating
//        self.isRefreshAnimating = true;
//        
////        UIView.animateWithDuration(2, delay:0, options: .CurveEaseOut, animations: {
////            self.blurEffectView.alpha = 1
////            }, completion: { finished in
////                if(self.refreshControl!.refreshing){
////                    self.blurEffectView.alpha = 0
////                }
////        })
//    }
    
    func resetAnimation() {
        print("resetAnimation")
        // Reset our flags and }background color
        blurEffectView.alpha = 0
        self.isRefreshAnimating = false;
        self.isRefreshIconsOverlap = false;
        self.refreshColorView.backgroundColor = UIColor.clearColor()
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
