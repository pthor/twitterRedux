//
//  TweetDetailView.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/19/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class TweetDetailView: UIView{
    
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var tweetUserAvatarImage: UIImageView!
    @IBOutlet weak var tweetUserFullNameLabel: UILabel!
    @IBOutlet weak var tweetUserNameLabel: UILabel!
    @IBOutlet weak var tweedAtTimeLabel: UILabel!

    var tweet: Tweet!{
        didSet{
            tweetUserAvatarImage.image = nil
            tweetMessageLabel.text = tweet.text
            tweedAtTimeLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()
            if(tweet.user != nil ){
                tweetUserFullNameLabel.text = tweet.user!.name
                tweetUserNameLabel.text = tweet.user!.screenname
                if (tweet.user!.profileImageUrl != nil){
                    let avatarImage = NSURL(string: tweet.user!.profileImageUrl!)
                    if avatarImage != nil{
                        tweetUserAvatarImage.setImageWithURL(avatarImage!)
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func tapLike(sender: UIButton) {
        print("like")
        if let likeedImage = UIImage(named: "like-action-on"){
            sender.setImage(likeedImage, forState: .Normal)
        }
    }
    
    /**
     - parameter duration: custom animation duration
     */
    func fadeIn(duration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(duration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 0.0
        })
    }

}