//
//  MenuViewController.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/25/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var tweetsNavigationController: UIViewController!
    private var profileNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    static let mentionsMenuTitle = "@mentions"
    static let logoutMenuTitle = "signout"
    static let profiletMenuTitle = "profile"
    static let twitterFeedMenuTitle = "home"
    
    var hamburgerViewController: HambergerViewController!
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [twitterFeedMenuTitle,profiletMenuTitle, mentionsMenuTitle, logoutMenuTitle]
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        print("viewDidLoad")
        
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 0.0 / 255.0, green: 132.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)

        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tweetsNavigationController = storyBoard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
        profileNavigationController  = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController")
        mentionsNavigationController  = storyBoard.instantiateViewControllerWithIdentifier("ProfileNavigationController")
        
        viewControllers.append(tweetsNavigationController)
        viewControllers.append(profileNavigationController)
        viewControllers.append(mentionsNavigationController)
        
        hamburgerViewController.contentViewController = tweetsNavigationController
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .Default, reuseIdentifier: nil) as? MenuItemTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemViewCell", forIndexPath: indexPath) as UITableViewCell as! MenuItemTableViewCell

        print(data[indexPath.row])
        cell.menuItemLabel.text = data[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("data.count \(data.count)")
        return data.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if( MenuViewController.mentionsMenuTitle == data[indexPath.row]){
            let menttionsVC =  viewControllers[indexPath.row] as! ProfileNavigationViewController
            menttionsVC.user = User.currentUser
            menttionsVC.showMentions = true
            print("show mentions")
            hamburgerViewController.contentViewController = menttionsVC

        }
        if( MenuViewController.profiletMenuTitle == data[indexPath.row]){
            let profileVC =  viewControllers[indexPath.row] as! ProfileViewController
            //let profileNavigationVC = profileVC.navigationController as! ProfileNavigationViewController
            profileVC.user = User.currentUser
            print("Profile mentions")
            hamburgerViewController.contentViewController = profileVC

        }
        else if(MenuViewController.logoutMenuTitle == data[indexPath.row]){
            print("log out menu item clicked")
            User.logout()
        }
        else{
            hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
            //cell.backgroundColor = UIColor.blueColor()
    }
    

}
