//
//  ActivityIndicatorViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-6.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class ActivityIndicatorViewController: UITableViewController {

    @IBOutlet var grayStyleActivityIndicatorView : UIActivityIndicatorView
    @IBOutlet var tintedActivityIndicatorView : UIActivityIndicatorView
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    /*
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray)
        activityIndicatorView.frame = CGRectMake(140.0, 120.0, 40.0, 40.0)
        activityIndicatorView.startAnimating()
        self.view.addSubview(activityIndicatorView) */
        
        self.configureGrayActivityIndicatorView();
        self.configureTintedActivityIndicatorView();


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //#pragma mark - Configuration
    
    func configureGrayActivityIndicatorView() {
        
        println(grayStyleActivityIndicatorView.superview) //return nil, bug?
        
        grayStyleActivityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray;
        
        grayStyleActivityIndicatorView.startAnimating();
    
        grayStyleActivityIndicatorView.hidesWhenStopped = false;
    }
    
    func configureTintedActivityIndicatorView() {
        self.tintedActivityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray;
    
        self.tintedActivityIndicatorView.color = UIColor.purpleColor();
            
        self.tintedActivityIndicatorView.startAnimating();
    }
    

    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    */

    /*
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}
