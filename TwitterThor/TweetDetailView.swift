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
    @IBOutlet weak var likeTweetButton: UIButton!
    @IBOutlet weak var reweetButton: UIButton!
    
    var userDidLikeTweet = false
    var userDidRetweet = false
    
    var tweet: Tweet!{
        didSet{
            print("Update tweet detail view")
            tweetUserAvatarImage.image = nil
            tweetMessageLabel.text = tweet.text
            tweedAtTimeLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()
            self.setLikeButtonState(tweet)
            self.setRetweetButtonState(tweet)
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
    
    func setLikeButtonState(tweetToDisplay: Tweet){
        let buttonInfo = LikeButton()
        let image =  tweetToDisplay.liked ? buttonInfo.selectedBackgroundImage : buttonInfo.defaultBackgroundImage
        self.setButtonState(image, button: self.likeTweetButton, buttonInfo: buttonInfo)

    }
    
    func setRetweetButtonState(tweetToDisplay: Tweet){
        let buttonInfo = RetweetButton()
        let image =  tweetToDisplay.retweeted ? buttonInfo.selectedBackgroundImage : buttonInfo.defaultBackgroundImage
        self.setButtonState(image, button: self.reweetButton, buttonInfo: buttonInfo)
    }
    
    func setButtonState(image: UIImage?, button: UIButton?,buttonInfo: TwitterActionButton){
        if image != nil && button != nil{
            button!.setImage(image!, forState: .Normal)
        }
    }
    
    @IBAction func tapLike(sender: UIButton) {
        if(tweet != nil){
            if(userDidLikeTweet)
            {
                //TODO unlike
                print("unlike")
            }
            else{
                print("like")
                if let likeedImage = UIImage(named: "like-action-on"){
                    sender.setImage(likeedImage, forState: .Normal)
                }
                User.likeTweet(tweet)
            }
        }
        
    }
    
    
    @IBAction func tapRetweet(sender: UIButton) {
        if(tweet != nil){
            if(userDidRetweet)
            {
                print("unretweet")
                //TODO unlike
            }
            else{
                userDidRetweet = true
                print("retwteet")
                if let likeedImage = RetweetButton().selectedBackgroundImage{
                    sender.setImage(likeedImage, forState: .Normal)
                }
                User.retweet(tweet)
            }
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

class TwitterActionButton: NSObject{
    var defaultBackgroundImage: UIImage? = nil
    var selectedBackgroundImage: UIImage? = nil
}

class LikeButton: TwitterActionButton{
    override init(){
        super.init()
        self.defaultBackgroundImage =  UIImage(named: "like-action")
        self.selectedBackgroundImage = UIImage(named: "like-action-on")
    }
}

class RetweetButton: TwitterActionButton{
    override init(){
        super.init()
        self.defaultBackgroundImage =  UIImage(named: "retweet-action")
        self.selectedBackgroundImage = UIImage(named: "retweet-action-on")
    }
}

class ReplyButton: TwitterActionButton{
    override init(){
        super.init()
        self.defaultBackgroundImage =  UIImage(named: "reply-action_0")
        self.selectedBackgroundImage = UIImage(named: "reply-action-pressed_0")
    }
}