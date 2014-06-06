//
//  GravityViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-6.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {
    
    @IBOutlet var box1 : UIImageView
    var animator : UIDynamicAnimator?
    
    //| ----------------------------------------------------------------------------
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated);
        
        let animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view);
        
        let gravityBeahvior:UIGravityBehavior = UIGravityBehavior(items:[self.box1]);
        animator.addBehavior(gravityBeahvior);
        
        self.animator = animator;
    }
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
