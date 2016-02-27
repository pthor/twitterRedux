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
    private var blueNavigationController: UIViewController!
    private var pinkNavigationController: UIViewController!
    
    var hamburgerViewController: HambergerViewController!
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = ["Home","Blue","Red"]
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        print("viewDidLoad")
        
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        tableView.dataSource = self
        tableView.delegate = self
        tweetsNavigationController = storyBoard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
        blueNavigationController  = storyBoard.instantiateViewControllerWithIdentifier("BlueNavigationController")
        pinkNavigationController  = storyBoard.instantiateViewControllerWithIdentifier("PinkNavigationController")
        
        viewControllers.append(tweetsNavigationController)
        viewControllers.append(blueNavigationController)
        viewControllers.append(pinkNavigationController)
        
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
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
       // hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        
    }
    

}
