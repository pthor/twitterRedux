//
//  Tweet.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/16/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    
    lazy var createdAt: NSDate? = {
        Tweet.dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        return Tweet.dateFormatter.dateFromString(self.createdAtString!)
    }()
    
    var dictionary: NSDictionary?
    static let dateFormatter = NSDateFormatter()
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
