//
//  TwitterClient.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/15/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1RequestOperationManager {
    
    static let twitterConsumerKey = "m8Jhm9qyGxjYadvUlqEGPddkQ"
    static let twitterConsumerSecret = "fwiMpXRyU6TqLeXY74fS0AboM7lTsZNrTHGj6oG4tMtUR1NhXk"
    
    static let oauthCallbackUrl =  NSURL(string: "twitterthor://oath")
    
    static let twitterBaseURL = NSURL(string:"https://api.twitter.com/")!
    static let twitterAuthorizePath = NSURL(string:"oauth/authorize")!
    static let oauthRequestTokenPath = "oauth/request_token"
    static let accountCredentialsPath = "/1.1/account/verify_credentials.json"
    static let homeTimelinePath = "/1.1/statuses/home_timeline.json"
    static let newTweetPath = "/1.1/statuses/update.json"
    static let likeTweetPath = "1.1/favorites/create.json"
    static func retweetPath(tweetID: String?) -> String{
        print("/1.1/statuses/retweet/\(tweetID!).json")
      return "/1.1/statuses/retweet/\(tweetID!).json"
    }
    
    var loginCompletionBlock: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient{
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : TwitterClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance!
    }
    
    static func getUserDetails(){
        TwitterClient.sharedInstance.GET(accountCredentialsPath, parameters: nil, success: {(operation: AFHTTPRequestOperation!, resposne: AnyObject!) -> Void in
                let user = User(dictionary: resposne as! NSDictionary)
                User.currentUser = user
                print("user name \(user.name)")
                print("current_user \(resposne)")
                TwitterClient.sharedInstance.loginCompletionBlock!(user:user, error: nil)
            }, failure: {(operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                print("#FAIL failed to get user detail: \(error.localizedDescription)")
                TwitterClient.sharedInstance.loginCompletionBlock!(user:nil, error: error)
            })
    }
    
    static func postTweet(tweetText:String, onSuccessBlock: ()->()){
        var paramaters = [String:String]()
        paramaters["status"] = tweetText
        TwitterClient.sharedInstance.POST(newTweetPath, parameters: paramaters, constructingBodyWithBlock: { (operation:AFMultipartFormData) -> Void in
            //noop
            }, success: { (operation: AFHTTPRequestOperation, response: AnyObject) -> Void in
                onSuccessBlock()
                print("You tweeted \(tweetText) !! ")
            }) { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                print("failed to post tweet")
        }
    }
    
    static func likeTweet(tweet:Tweet, onSuccessBlock: ()->()){
        var paramaters = [String:String]()
        paramaters["id"] = tweet.id_str
        print("POST like tweet \(paramaters["id"])")
        TwitterClient.sharedInstance.POST(likeTweetPath, parameters: paramaters, constructingBodyWithBlock: { (operation:AFMultipartFormData) -> Void in
            //noop
            }, success: { (operation: AFHTTPRequestOperation, response: AnyObject) -> Void in
                onSuccessBlock()
                print("You like \(tweet.text) !! ")
            }) { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                print("failed to like tweet. \(error.debugDescription) ")
        }
    }
    
    static func retweet(tweet:Tweet, onSuccessBlock: ()->()){
        var paramaters = [String:String]()
        paramaters["id"] = tweet.id_str
        print("POST retweet\(paramaters["id"])")
        TwitterClient.sharedInstance.POST(retweetPath(paramaters["id"]), parameters: paramaters, constructingBodyWithBlock: { (operation:AFMultipartFormData) -> Void in
            //noop
            }, success: { (operation: AFHTTPRequestOperation, response: AnyObject) -> Void in
                onSuccessBlock()
                print("You retweeted \(tweet.text) !! ")
            }) { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                print("failed to retweet. \(error.debugDescription) ")
        }
    }
    
    static func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        TwitterClient.sharedInstance.GET(homeTimelinePath, parameters: nil, success: {(operation: AFHTTPRequestOperation!, resposne: AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(resposne as! [NSDictionary])
            completion(tweets: tweets, error: nil)
        }, failure: {(operation: AFHTTPRequestOperation?, error: NSError) -> Void in
            completion(tweets: nil, error: error)
        })
    }
    
    static func oathAuthorizeUrl(token:String) -> String{
        return "\(twitterBaseURL)\(twitterAuthorizePath)?oauth_token=\(token)"
    }
    
    static func loginWithCompletion(completion: (user: User?, error: NSError?) -> ())
    {
        TwitterClient.sharedInstance.loginCompletionBlock = completion
        
        //Fetch my request token & redirect
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath( TwitterClient.oauthRequestTokenPath, method: "POST", callbackURL: TwitterClient.oauthCallbackUrl, scope: nil, success: { (requestCredential: BDBOAuth1Credential!) -> Void in
            print("got the request toke \(requestCredential.token)")
            let  authURL = NSURL(string: TwitterClient.oathAuthorizeUrl(requestCredential.token))
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("got an error \(error.localizedDescription )")
                TwitterClient.sharedInstance.loginCompletionBlock!(user:nil, error: error)
        }
    }
    
    static func logout()
    {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    }
    
    static func openURL(url: NSURL){
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query!), success: { (successCredential:BDBOAuth1Credential!) -> Void in
            print("got the access token \(successCredential.token)")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(successCredential!)
            TwitterClient.getUserDetails()
            //TwitterClient.getUserTimeline()
            }) { (error:NSError!) -> Void in
                print("failed to receive acess token")
        }
    }
    
    static func isURLOAuthCallbackURL(url: NSURL) -> Bool
    {
        return ((url.description.rangeOfString((TwitterClient.oauthCallbackUrl?.description)!)) != nil)
    }

    

}
