//
//  GravityViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-10.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class InstantaneousPushViewController: UIViewController {
    
    @IBOutlet var box1 : UIImageView
    var animator : UIDynamicAnimator?
    //! Reference to the previously applied snap behavior.
    var pushBehavior:UIPushBehavior?;
    
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
    
    //| ----------------------------------------------------------------------------
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated);
        
        let animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        var collisionBehavior:UICollisionBehavior = UICollisionBehavior(items:[self.box1])
        // Account for any top and bottom bars when setting up the reference bounds.
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundaryWithInsets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0))
        animator.addBehavior(collisionBehavior)
        
        var pushBehavior:UIPushBehavior = UIPushBehavior(items:[self.box1], mode:UIPushBehaviorMode.Instantaneous)
        pushBehavior.angle = 0.0
        pushBehavior.magnitude = 0.0
        animator.addBehavior(pushBehavior)
        self.pushBehavior = pushBehavior
        
        self.animator = animator
    }
    
    
    @IBAction func handlePushContinousGesture(gesture : UITapGestureRecognizer) {
        // Tapping will change the angle and magnitude of the impulse. To visually
        // show the impulse vector on screen, a red arrow representing the angle
        // and magnitude of this vector is briefly drawn.
        var p:CGPoint = gesture.locationInView(self.view)
        var o:CGPoint = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        var distance:CGFloat = sqrtf(powf(p.x-o.x, 2.0)+powf(p.y-o.y, 2.0))
        var angle:CGFloat = CGFloat(atan2(CDouble(p.y-o.y), CDouble(p.x-o.x)))
        distance = min(distance, 100.0)
        
        // Display an arrow showing the direction and magnitude of the applied force.
        (self.view as UIDCDecorationView).drawMagnitudeVector(distance, angle:angle, color:UIColor.redColor(), forLimitedTime:true)
        
        // These two lignes change the actual force vector.
        self.pushBehavior!.magnitude = distance / 100.0
        self.pushBehavior!.angle = angle
        
        // A push behavior in instantaneous (impulse) mode automatically
        // deactivate itself after applying the impulse. We thus need to reactivate
        // it when changing the impulse vector.
        self.pushBehavior!.active = true
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
