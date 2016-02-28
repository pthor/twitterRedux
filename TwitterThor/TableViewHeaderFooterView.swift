//
//  TableViewHeaderViewCell.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/27/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class TableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    var user: User!{
        didSet{
            if (user.profile_banner_url != nil){
                let avatarImage = NSURL(string: user.profile_banner_url!)
                if avatarImage != nil{
                    headerImageView.setImageWithURL(avatarImage!)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.user = User.currentUser
        // Initialization code
    }

    @IBOutlet weak var headerImageView: UIImageView!
    


}
