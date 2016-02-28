//
//  ProfileNavigationViewController.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/28/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class ProfileNavigationViewController: UINavigationController {
    
    var user: User?{
        didSet{
            print("ProfileNavigationViewController.user = \(user?.screenname)")
            self.title = user?.screenname
        }
    }
    
    var showMentions: Bool = false{
        didSet{
            print("ProfileNavigationViewController.showMentions = \(showMentions)")
            if(showMentions){
                self.title = "@\(self.title)"
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "showMentions \(showMentions)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
