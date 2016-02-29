//
//  BasicTweetTableViewCell.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/18/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit
import AFNetworking
import DateTools

class BasicTweetTableViewCell: UITableViewCell {

    
    var tweet: Tweet!{
        didSet{
            tweetUserAvatarImage.image = nil
            tweetMessageLabel.text = tweet.text
            tweedAtTimeLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()
            likesCountLabel.text = "\(tweet.favouritesCount)"
            retweetsCountLabel.text = "\(tweet.retweetCount)"
            
            if(likeButton != nil && tweet.liked){
                likeButton!.setImage(LikeButton().selectedBackgroundImage, forState: .Normal)
            }
            else{
                likeButton!.setImage(LikeButton().defaultBackgroundImage, forState: .Normal)
            }
            
            if(retweetButton != nil && tweet.retweeted){
                retweetButton!.setImage(RetweetButton().selectedBackgroundImage, forState: .Normal)
            }
            else{
                retweetButton!.setImage(RetweetButton().defaultBackgroundImage, forState: .Normal)
            }
            
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
            
            let tap = UITapGestureRecognizer(target: self, action: "onImageTap")
            tweetUserAvatarImage.addGestureRecognizer(tap)
            tweetUserAvatarImage.userInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var tweetUserAvatarImage: UIImageView!
    @IBOutlet weak var tweetUserFullNameLabel: UILabel!
    @IBOutlet weak var tweetUserNameLabel: UILabel!
    @IBOutlet weak var tweedAtTimeLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    weak var navigationController: UINavigationController!
    
    @IBAction func onLikeButtonTap(sender: AnyObject) {
        User.likeTweet(tweet)
    }


    @IBAction func onRetweetTap(sender: AnyObject) {
         User.retweet(tweet)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetUserAvatarImage.layer.cornerRadius = 5
        tweetUserAvatarImage.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onImageTap(){
        print("TAP IT IN HAPPY JUST TAP IT IN")
        //let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as LoginViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let userProfileController  = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController") as? ProfileViewController{
            userProfileController.user = self.tweet.user
            userProfileController.showMentions = false
            print("PUSH TO NEW VIEW FOR USER \(self.tweet.user?.screenname)")
            self.navigationController?.pushViewController(userProfileController, animated: true)
        }
    }

}
