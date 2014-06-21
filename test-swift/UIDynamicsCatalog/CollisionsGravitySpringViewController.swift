//
//  CollisionsGravitySpringViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-14.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class CollisionsGravitySpringViewController: UIViewController {
    //! The view that displays the attachment point on square1.
    var square1AttachmentView : UIImageView!
    //! The view that the user drags to move square1.
    var attachmentView : UIImageView!
    var square1 : UIView!

    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    
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
        
        
        
        let box1:UIImageView = UIImageView(image:UIImage(named:"box1"))
        self.attachmentView = UIImageView(image:UIImage(named:"AttachmentPoint_Mask"))
        self.square1AttachmentView = UIImageView(image:UIImage(named:"AttachmentPoint_Mask"))
        
        self.attachmentView.center = CGPointMake(self.view.center.x, 170)
        
        self.square1 = UIView(frame: box1.frame)
        self.square1.center = CGPointMake(self.view.center.x, 320)
        self.square1.addSubview(box1)
        self.square1.addSubview(square1AttachmentView)
        
        self.view.addSubview(self.square1)
        self.view.addSubview(self.attachmentView)
  
        
        let animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items:[self.square1])
        // Creates collision boundaries from the bounds of the dynamic animator's
        // reference view (self.view).
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
        
        let squareCenterPoint:CGPoint = CGPointMake(self.square1.center.x, self.square1.center.y - 110.0)
        let attachmentPoint:UIOffset = UIOffsetMake(-25.0, -25.0);
        // By default, an attachment behavior uses the center of a view. By using a
        // small offset, we get a more interesting effect which will cause the view
        // to have rotation movement when dragging the attachment.
        
        let attachmentBehavior:UIAttachmentBehavior = UIAttachmentBehavior(item:self.square1, offsetFromCenter:attachmentPoint, attachedToAnchor:squareCenterPoint)
        
        animator.addBehavior(attachmentBehavior)
        self.attachmentBehavior = attachmentBehavior
        
        // Visually show the attachment points
        self.attachmentView.center = attachmentBehavior.anchorPoint
        self.attachmentView.tintColor = UIColor.redColor()
        self.attachmentView.image = self.attachmentView.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        self.square1AttachmentView.center = CGPointMake(25.0, 25.0)
        self.square1AttachmentView.tintColor = UIColor.blueColor()
        self.square1AttachmentView.image = self.square1AttachmentView.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        // Visually show the connection between the attachment points.
        (self.view as UIDCDecorationView).trackAndDrawAttachmentFromView(self.attachmentView, toView:self.square1, withAttachmentOffset:CGPointMake(-25.0, -25.0));
        
        // These parameters set the attachment in spring mode, instead of a rigid
        // connection.
        attachmentBehavior.frequency = 1.0
        attachmentBehavior.damping = 0.1
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items:[self.square1])
        animator.addBehavior(gravityBehavior)
        
        self.animator = animator;
        
        JLToast.makeText("A little different from the apple's for fun").show()
        
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

    @IBAction func handleAttachmentGesture(sender : UIPanGestureRecognizer) {
        self.attachmentBehavior!.anchorPoint = sender.locationInView(self.view)
        self.attachmentView.center = self.attachmentBehavior!.anchorPoint
        
        print("aaaa->")
        println(self.attachmentView)
        print("bbbb->")
        println(self.square1)
        
    }

}
