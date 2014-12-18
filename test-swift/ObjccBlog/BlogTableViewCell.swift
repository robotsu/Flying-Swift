//
//  BlogTableViewCell.swift
//  test-swift
//
//  Created by Su Wei on 14-6-19.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {
    
    var post: BlogPost!

    @IBOutlet var titleImage : UIImageView!
    @IBOutlet var titleLabel : UILabel!
    
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
        
        if post.img_url != "" {
            //println(post.title + " url: \(post.img_url)")
            self.titleImage.setImage(post.img_url, placeHolder: UIImage(named: "BackgroundTile"))
        }else{
            self.titleImage.image = UIImage(named: "BackgroundTile")
        }
        
        self.titleImage.frame = CGRectMake(6,6,88,88)
        
        self.titleLabel.text = post.title
        self.titleLabel.numberOfLines = 0
        
        super.layoutSubviews()
    }
    
}
