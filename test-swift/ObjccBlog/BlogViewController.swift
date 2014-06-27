//
//  BlogViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-19.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableview: UITableView?
    let posts = NSMutableArray()
    let identifier = "cell"
    let indicator = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray)
    let refreshControl = UIRefreshControl()
    
    let wvc = BlogWebViewController(nibName:nil, bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "blog.objcc.com"
        
        self.tableview = UITableView(frame:self.view.frame)
        self.tableview!.delegate = self
        self.tableview!.dataSource = self
        self.tableview!.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
        var nib = UINib(nibName:"BlogTableViewCell", bundle: nil)
        
        self.tableview!.registerNib(nib, forCellReuseIdentifier: identifier)
        //self.tableview!.estimatedRowHeight = 44.0
        //self.tableview!.rowHeight = UITableViewAutomaticDimension
        
        self.view.addSubview(self.tableview)
        
        self.indicator.center = self.view.center
        self.indicator.hidesWhenStopped = true
        self.view.addSubview(self.indicator)
        
        self.tableview!.addSubview(refreshControl)
        refreshControl.addTarget(self, action:"refreshTable", forControlEvents:UIControlEvents.ValueChanged)
        
        self.indicator.startAnimating()
        refreshTable()
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
    
    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.posts.count
    }
    
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var cell = tableView!.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as BlogTableViewCell
        
        // Configure the cell...
        
        var index = indexPath!.row
        cell.post = self.posts[index] as NSDictionary
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var index = indexPath!.row
        //JLToast.makeText("row #\(index) selected").show()
        
        let urlString = (self.posts[index] as NSDictionary )["url"] as? String
        wvc.loadUrl(string: urlString!)
        self.navigationController.pushViewController(wvc, animated:true)
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
        
        let url = NSURL.URLWithString("http://blog.objcc.com/api-v1/get_recent_posts/")
        let req = NSURLRequest(URL: url)
        let queue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if error {
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
    
    func refreshTable () {
        getJsonData( { data in
            if data as NSObject == NSNull() {
                JLToast.makeText("Network Error").show()
                return
            }
            
            //println(data)
            
            var arr = data["posts"] as NSArray
            
            for data : AnyObject in arr {
                self.posts.addObject(data)
            }
            
            self.tableview!.reloadData()
            
            if self.indicator.isAnimating() {
                self.indicator.stopAnimating()
            }
            
            if self.refreshControl.refreshing {
                self.refreshControl.endRefreshing()
            }
        })
    }
    
}