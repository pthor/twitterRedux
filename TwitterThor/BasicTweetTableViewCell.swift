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
//            categoriesLabel.text = tweet.categories
//            addressLabel.text = tweet.address
            //reviewsCountLabel.text = "\(tweet.reviewCount!) retweeted"
            //distanceLabel.text = tweet.distance
        }
    }
    
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var tweetUserAvatarImage: UIImageView!
    @IBOutlet weak var tweetUserFullNameLabel: UILabel!
    @IBOutlet weak var tweetUserNameLabel: UILabel!
    @IBOutlet weak var tweedAtTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetUserAvatarImage.layer.cornerRadius = 5
        tweetUserAvatarImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
