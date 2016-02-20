//
//  TweetDetailContainerView.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/19/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class TweetDetailContainerView: UIView {    
    
    override func awakeFromNib() {
                super.awakeFromNib()
                self.layer.cornerRadius = 20
                self.clipsToBounds = true
    }
    
}
