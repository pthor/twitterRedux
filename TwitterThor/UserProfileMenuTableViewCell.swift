//
//  UserProfileMenuTableViewCell.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/28/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class UserProfileMenuTableViewCell: UITableViewCell {
    

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var screenNameLable: UILabel!
    @IBOutlet weak var UserNameLable: UILabel!
    
    var user: User!{
        didSet{
            if(user != nil ){
                UserNameLable.text = user!.name
                screenNameLable.text = user!.screenname
                if (user!.profileImageUrl != nil){
                    let avatarImage = NSURL(string: user!.profileImageUrl!)
                    if userProfileImage != nil{
                        userProfileImage.setImageWithURL(avatarImage!)
                    }
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userProfileImage.layer.cornerRadius = 24
        userProfileImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
