//
//  GravityViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-6.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class CollisionGravityViewController: UIViewController, UICollisionBehaviorDelegate{
    
    @IBOutlet var box1 : UIImageView
    var animator : UIDynamicAnimator?
    
    //| ----------------------------------------------------------------------------
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated);
        
        let animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view);
        
        let gravityBeahvior:UIGravityBehavior = UIGravityBehavior(items:[self.box1]);
        animator.addBehavior(gravityBeahvior);
        
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items:[self.box1]);
        // Creates collision boundaries from the bounds of the dynamic animator's
        // reference view (self.view).
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true;
        collisionBehavior.collisionDelegate = self;
        animator.addBehavior(collisionBehavior);
        
        self.animator = animator;
    }
    
    //UICollisionBehaviorDelegate
    
    //| ----------------------------------------------------------------------------
    //  This method is called when square1 begins contacting a collision boundary.
    //  In this demo, the only collision boundary is the bounds of the reference
    //  view (self.view).
    //
    func collisionBehavior(behavior: UICollisionBehavior!, beganContactForItem item: UIDynamicItem!, withBoundaryIdentifier identifier: NSCopying!, atPoint p: CGPoint)
    {
        // Lighten the tint color when the view is in contact with a boundary.
        (item as UIView).tintColor = UIColor.lightGrayColor()
    }
    
    
    //| ----------------------------------------------------------------------------
    //  This method is called when square1 stops contacting a collision boundary.
    //  In this demo, the only collision boundary is the bounds of the reference
    //  view (self.view).
    //
    //- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
    func collisionBehavior(behavior: UICollisionBehavior!, endedContactForItem item: UIDynamicItem!, withBoundaryIdentifier identifier: NSCopying!)
    
    {
        // Restore the default color when ending a contcact.
        (item as UIView).tintColor = UIColor.darkGrayColor();
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
        
        // Make the square a template image so its color can be changed
        // by adjusting the tintColor of the UIImageView displaying it.
        //self.square1.image = [self.square1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.box1.image = self.box1.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)

        self.box1.tintColor = UIColor.darkGrayColor();
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
