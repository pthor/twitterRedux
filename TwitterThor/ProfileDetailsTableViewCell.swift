//
//  ProfileDetailsTableViewCell.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/27/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class ProfileDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User!{
    
        didSet{
            if(user != nil ){
                fullNameLabel.text = user!.name
                userNameLabel.text = user!.screenname
                followingCountLabel.text = "\(user!.numFollowing!)"
                followersCountLabel.text = "\(user!.numFollowers!)"
                
                if (user!.profileImageUrl != nil){
                    let avatarImage = NSURL(string: user!.profileImageUrl!)
                    if profileImageView != nil{
                        profileImageView.setImageWithURL(avatarImage!)
                    }
                }
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
