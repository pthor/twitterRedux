//
//  User.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/16/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "com.pthormahlen.User.key"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutnNotification = "userDidLogoutnNotification"
let userDidTweetNotification = "userDidTweetNotification"


class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary

        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    static func logout(){
        currentUser = nil
        TwitterClient.logout()
        let notification = NSNotification(name: userDidLogoutnNotification, object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    static func postTweet(tweetText: String){
        TwitterClient.postTweet(tweetText){
            print("send notification")
            let notification = NSNotification(name: userDidTweetNotification, object: nil)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
        
    }
    
    class var currentUser: User?{
        get{
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil{
                    do{
                        let dictionary =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    }
                    catch{
                        print("error reading user")
                    }
                }
                    
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            if(_currentUser != nil){
                do{
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    //handle error. Probably return or mark function as throws
                    print("error")
                }
            }else{
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()

        }
        
    }
}
