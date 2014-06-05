//
//  ViewController.swift
//  UITableView-Swift
//
//  Created by YANGRui on 14-6-4.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit

class UITableViewSwiftViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource
{
    var tableView : UITableView?
    var items :NSMutableArray?
    var leftBtn:UIButton?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "I love Swift"
        self.items = NSMutableArray()
       // self.items?.addObject("1","2")
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
        setupRightBarButtonItem()
        setupLeftBarButtonItem();
        self.navigationItem.leftItemsSupplementBackButton = true //suwei 2014.6.5
    }
    
    func setupViews()
    {
        self.tableView = UITableView(frame:self.view!.frame)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view?.addSubview(self.tableView)
    }
    
    func setupLeftBarButtonItem()
    {
        self.leftBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        self.leftBtn!.frame = CGRectMake(0,0,50,40)
        self.leftBtn?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        self.leftBtn!.tag = 100
        self.leftBtn!.userInteractionEnabled = false
        self.leftBtn?.addTarget(self, action: "leftBarButtonItemClicked", forControlEvents: UIControlEvents.TouchUpInside)
        var barButtonItem = UIBarButtonItem(customView: self.leftBtn)
        self.navigationItem!.leftBarButtonItem = barButtonItem
    }
    
    func setupRightBarButtonItem()
    {
        var barButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "rightBarButtonItemClicked")
        self.navigationItem!.rightBarButtonItem = barButtonItem
    }
    
    func rightBarButtonItemClicked()
    {
      
        var row = self.items!.count
        var indexPath = NSIndexPath(forRow:row,inSection:0)
        self.items?.addObject("1")
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
         self.leftBtn!.userInteractionEnabled = true
    }
    
    func leftBarButtonItemClicked()
    {
        if (self.leftBtn!.tag == 100)
        {
            self.tableView?.setEditing(true, animated: true)
            self.leftBtn!.tag = 200
            self.leftBtn?.setTitle("Done", forState: UIControlState.Normal)
        }
        else
        {
            self.tableView?.setEditing(false, animated: true)
            self.leftBtn!.tag = 100
            self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.items!.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = String(format: "%i", indexPath.row+1)
        return cell
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        self.items?.removeObjectAtIndex(indexPath.row)
    
        self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        if (self.items!.count == 0)
        {
             self.leftBtn!.userInteractionEnabled = false
        }
       
    }
    
     func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle
    {
        return (UITableViewCellEditingStyle.Delete)
    }
    
    func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
         return true
    }
    
    func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!)
    {
        self.tableView?.moveRowAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
        self.items?.exchangeObjectAtIndex(sourceIndexPath.row, withObjectAtIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        println("row = %d",indexPath.row)
    }
    
    
    
    
    
    

}

