//
//  BlogTableViewCell.swift
//  test-swift
//
//  Created by Su Wei on 14-6-19.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {
    
    var post :NSDictionary!

    @IBOutlet var titleLabel : UILabel
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.text = post["title"] as String
    }
    
}
