//
//  GravityViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-6.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class ItemPropertiesViewController: UIViewController {
    
    @IBOutlet var square1 : UIImageView
    @IBOutlet var square2 : UIImageView
    var square1PropertiesBehavior:UIDynamicItemBehavior?
    var square2PropertiesBehavior:UIDynamicItemBehavior?
    var animator : UIDynamicAnimator?
    
    //| ----------------------------------------------------------------------------
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated);
        
        let animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        // We want to show collisions between views and boundaries with different
        // elasticities, we thus associate the two views to gravity and collision
        // behaviors. We will only change the restitution parameter for one of these
        // views.
        let gravityBeahvior:UIGravityBehavior = UIGravityBehavior(items:[self.square1, self.square2])
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items:[self.square1, self.square2])
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        
        // A dynamic item behavior gives access to low-level properties of an item
        // in Dynamics, here we change restitution on collisions only for square2,
        // and keep square1 with its default value.
        self.square2PropertiesBehavior = UIDynamicItemBehavior(items:[self.square2])
        self.square2PropertiesBehavior!.elasticity = 0.5
        
        // A dynamic item behavior is created for square1 so it's velocity can be
        // manipulated in the -resetAction: method.
        self.square1PropertiesBehavior = UIDynamicItemBehavior(items:[self.square1])
        
        animator.addBehavior(self.square1PropertiesBehavior)
        animator.addBehavior(self.square2PropertiesBehavior)
        animator.addBehavior(gravityBeahvior)
        animator.addBehavior(collisionBehavior)

        
        self.animator = animator
    }
    
    @IBAction func replayAction(sender : AnyObject) {
        // Moving an item does not reset its velocity.  Here we do that manually
        // using the dynamic item behaviors, adding the inverse velocity for each
        // square.
        self.square1PropertiesBehavior!.addLinearVelocity(CGPointMake(0, -1 * self.square1PropertiesBehavior!.linearVelocityForItem(self.square1).y), forItem:self.square1)
        self.square1.center = CGPointMake(90, 171)
        self.animator!.updateItemUsingCurrentState(self.square1)
        
        self.square2PropertiesBehavior!.addLinearVelocity(CGPointMake(0, -1 * self.square2PropertiesBehavior!.linearVelocityForItem(self.square2).y), forItem:self.square2)
        self.square2.center = CGPointMake(230, 171)
        self.animator!.updateItemUsingCurrentState(self.square2)
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
