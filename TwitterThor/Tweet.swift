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
    
    lazy var createdAt: NSDate? = {
        Tweet.dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        return Tweet.dateFormatter.dateFromString(self.createdAtString!)
    }()
    
    var dictionary: NSDictionary?
    static let dateFormatter = NSDateFormatter()
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        //print(dictionary)
        id_str = dictionary["id_str"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        liked = dictionary["favorited"] as! Bool
        retweeted = dictionary["retweeted"] as! Bool
        print("did user like tweet \(id_str): \(liked)?")
        print("did user retweet \(id_str): \(retweeted)?")
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
