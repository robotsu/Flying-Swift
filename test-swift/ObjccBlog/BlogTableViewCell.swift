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

    @IBOutlet var titleImage : UIImageView
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
        //self.titleImage.contentMode = UIViewContentMode.ScaleToFill
        
        let url = ((post["attachments"] as NSArray)[0] as NSDictionary)["url"] as String
        self.titleImage.setImage(url, placeHolder: UIImage(named: "BackgroundTile"))
        
        self.titleImage.frame = CGRectMake(6,6,88,88);

        self.titleLabel.text = post["title"] as String
        self.titleLabel.numberOfLines = 0
        super.layoutSubviews()
    }
    
}
