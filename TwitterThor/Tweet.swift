//
//  Tweet.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/16/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id_str: String?
    var user: User?
    var text: String?
    var createdAtString: String?
    var liked: Bool = false
    var retweeted: Bool = false
    var favouritesCount: String = ""
    var retweetCount: String = ""
    
    lazy var createdAt: NSDate? = {
        Tweet.dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        return Tweet.dateFormatter.dateFromString(self.createdAtString!)
    }()
    
    var dictionary: NSDictionary?
    static let dateFormatter = NSDateFormatter()
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        id_str = dictionary["id_str"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        liked = dictionary["favorited"] as! Bool
        retweeted = dictionary["retweeted"] as! Bool
        favouritesCount = dictionary["favorite_count"] != nil ? "\(dictionary["favorite_count"]!)" : ""
        retweetCount = dictionary["retweet_count"] != nil ? "\(dictionary["retweet_count"]!)" : ""
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
