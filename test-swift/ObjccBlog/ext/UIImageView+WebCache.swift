//
//  UIImageView+WebCache.swift
//  test-swift
//
//  Created by Su Wei on 14-6-20.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

/*
extension UIImage {
    func makeThumbnail(size:CGSize)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        // draw scaled image into thumbnail context
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newThumbnail = UIGraphicsGetImageFromCurrentImageContext()
        // pop the context
        UIGraphicsEndImageContext()
        if(newThumbnail == nil) {
            println("could not scale image")
        }
        return newThumbnail
    }
}*/

extension UIImageView {
    
    func setImage(urlString:String,placeHolder:UIImage!) {
        let this_urlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let url = NSURL(string: this_urlString!)!
        let imageName = url.lastPathComponent
        let fileCache = FileCache()
        let image : AnyObject = fileCache.getImage(imageName!)
        if image as NSObject != NSNull() {
            self.image = (image as UIImage)//.makeThumbnail(CGSizeMake(88,88))
        }
        else
        {
            let req = NSURLRequest(URL: url)
            let queue = NSOperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: {
                response, data, error in
                if (error != nil) {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.image = placeHolder
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        var image = UIImage(data: data)
                        if image == nil {
                            self.image = placeHolder
                        }
                        else
                        {
                            self.image = image//.makeThumbnail(CGSizeMake(88,88))
                            fileCache.saveImage(imageName!,image:data)
                        }
                    })
                }
            })
            
        }
    }
}


class FileCache: NSObject {
    
    let arr =  NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
    
    func getCachePath(fileName:String)->String {
        return "\(arr[0])/\(fileName)"
    }
    
    func saveImage(name:String,image:NSData)->Bool {
        let path = getCachePath(name)
        //println("save: "+path)
        return image.writeToFile(path, atomically: true)
    }
    
    func getImage(name:String)->AnyObject {
        let path = getCachePath(name)
        let exist = NSFileManager.defaultManager().fileExistsAtPath(path)
        //println("get:"+path)
        if exist {
            return  UIImage(contentsOfFile: path)!
        }
        return NSNull()
    }
}

