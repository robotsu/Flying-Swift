//
//  BlogViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-19.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableview: UITableView?
    let posts:NSMutableArray = NSMutableArray()
    let identifier = "cell"
    let indicator = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray)
    let refreshControl = UIRefreshControl();
    var page = 1
    var pages = 1
    var is_loading = false
    
    let wvc = BlogWebViewController(nibName:nil, bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "blog.objcc.com"
        
        self.tableview = UITableView(frame:self.view.frame)
        self.tableview!.separatorColor = UIColor.brownColor()
        self.tableview!.tableFooterView = UIView()
        self.tableview!.delegate = self
        self.tableview!.dataSource = self
        self.tableview!.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
        var nib = UINib(nibName:"BlogTableViewCell", bundle: nil)
        
        self.tableview!.registerNib(nib, forCellReuseIdentifier: identifier)
        //self.tableview!.estimatedRowHeight = 44.0
        //self.tableview!.rowHeight = UITableViewAutomaticDimension
        
        self.view.addSubview(self.tableview!)
        
        self.indicator.center = self.view.center
        self.indicator.hidesWhenStopped = true
        self.view.addSubview(self.indicator)
        
        self.tableview!.addSubview(refreshControl)
        refreshControl.addTarget(self, action:"pull2refresh", forControlEvents:UIControlEvents.ValueChanged)
        
        self.indicator.startAnimating()
        refreshTable(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as BlogTableViewCell
        
        // Configure the cell...
        
        var index = indexPath.row
        cell.post = self.posts[index] as BlogPost
        
        //load more
        if (indexPath.row == self.posts.count - 1 && pages>=page) {
            if !is_loading {
                JLToast.makeText("loading page: #\(page)").show()
                
                self.indicator.startAnimating()
                //println("need load more=========================\(page)")
                self.refreshTable(false)
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var index = indexPath!.row
        JLToast.makeText("row #\(index) is loading...").show()
        let urlString = (self.posts[index] as BlogPost).post_url
        
        wvc.loadUrl(string: urlString)
        self.navigationController!.pushViewController(wvc, animated:true)
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 100
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    func getJsonData(completionHandler:(data:AnyObject)->Void) {
        
        let url = NSURL(string: "http://blog.objcc.com/api-v1/get_recent_posts/?page=\(page)")
        let req = NSURLRequest(URL: url!)
        let queue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue(), {
                        println(error)
                        completionHandler(data:NSNull())
                    })
            }
            else
            {
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), {
                        completionHandler(data:jsonData)
                })
            }
        })
    }
    
    func pull2refresh() {
        refreshTable(true)
    }
    
    func refreshTable (is_pull:Bool) {
        if is_loading {
            return
        }
        
        if is_pull {
            page = 1
        }
        
        is_loading = true
        getJsonData( { data in
            if data as NSObject == NSNull() {
                JLToast.makeText("Network Error").show()
                self.is_loading = false
                return
            }
            
            //println("page: \(self.page)==========================")
            
            if self.page == 1 {
                //println("removeAllObjects..................")
                self.posts.removeAllObjects()
            }
            
            var arr = data["posts"] as NSArray
            self.pages = data["pages"] as Int
            
            for data : AnyObject in arr {
                
                var title = data["title"] as String
                var img_url: String = ""
                let attachments = data["attachments"] as NSArray
                if attachments.count > 0 {
                    img_url = (attachments[0] as NSDictionary)["url"] as String
                }
                
                var post_url = data["url"] as String
                var post = BlogPost(title: title, img_url:img_url, post_url:post_url)
                
                self.posts.addObject(post)
            }
            
            self.tableview!.reloadData()
            
            if self.indicator.isAnimating() {
                self.indicator.stopAnimating()
            }
            
            if self.refreshControl.refreshing {
                self.refreshControl.endRefreshing()
            }
            
            self.page++
            self.is_loading = false
        })
    }
    
}