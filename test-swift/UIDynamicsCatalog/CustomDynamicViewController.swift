//
//  CustomDynamicViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-11.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class CustomDynamicViewController: UIViewController {
    
    @IBOutlet var button1 : UIButton
    var button1Bounds : CGRect!
    var animator : UIDynamicAnimator!

    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    //| ----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Save the button's initial bounds.  This is necessary so that the bounds
        // can be reset to their initial state before starting a new simulation.
        // Otherwise, the new simulation will continue from the bounds set in the
        // final step of the previous simulation which may have been interrupted
        // before it came to rest (e.g. the user tapped the button twice in quick
        // succession).  Without reverting to the initial bounds, this would cause
        // the button to grow uncontrollably in size.
        self.button1Bounds = self.button1.bounds
        
        // Force the button image to scale with its bounds.
        self.button1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        self.button1.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //| ----------------------------------------------------------------------------
    //  IBAction for tapping the button in this demo.
    //
    @IBAction func buttonAction(sender : UIButton) {
        
        // Reset the buttons bounds to their initial state.  See the comment in
        // -viewDidLoad.
        self.button1.bounds = self.button1Bounds
        
        // UIDynamicAnimator instances are relatively cheap to create.
        let animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        // APLPositionToBoundsMapping maps the center of an id<ResizableDynamicItem>
        // (UIDynamicItem with mutable bounds) to its bounds.  As dynamics modifies
        // the center.x, the changes are forwarded to the bounds.size.width.
        // Similarly, as dynamics modifies the center.y, the changes are forwarded
        // to bounds.size.height.
        let buttonBoundsDynamicItem:UIDCPositionToBoundsMapping = UIDCPositionToBoundsMapping(target:sender)
        
        //let buttonBoundsDynamicItem:UIButton = sender

        
        // Create an attachment between the buttonBoundsDynamicItem and the initial
        // value of the button's bounds.
        let attachmentBehavior:UIAttachmentBehavior = UIAttachmentBehavior(item:buttonBoundsDynamicItem, attachedToAnchor:buttonBoundsDynamicItem.center)
        attachmentBehavior.frequency = 2.0
        attachmentBehavior.damping = 0.3
        animator.addBehavior(attachmentBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items:[buttonBoundsDynamicItem], mode:UIPushBehaviorMode.Instantaneous)
        pushBehavior.angle = CGFloat(M_PI_4)
        pushBehavior.magnitude = 2.0;
        
        animator.addBehavior(pushBehavior)
        
        pushBehavior.active = true
        
        self.animator = animator
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
