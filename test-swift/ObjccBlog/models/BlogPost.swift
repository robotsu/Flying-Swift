//
//  BlogPost.swift
//  test-swift
//
//  Created by Su Wei on 14-7-16.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import Foundation

class BlogPost : NSObject {
    
    init(title:String, img_url:String, post_url:String) {
        self.title = title;
        self.img_url = img_url;
        self.post_url = post_url;
    }
    
    var title: String = "";
    var img_url: String = "";
    var post_url: String = "";

}