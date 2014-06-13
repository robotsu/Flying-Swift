//
//  UIDCPendulumBehavior.swift
//  test-swift
//
//  Created by Su Wei on 14-6-13.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class UIDCPendulumBehavior: UIDynamicBehavior {
   
    var draggingBehavior : UIAttachmentBehavior!
    var pushBehavior : UIPushBehavior!
    
    //| ----------------------------------------------------------------------------
    //! Initializes and returns a newly allocated APLPendulumBehavior which suspends
    //! @a item hanging from @a p at a fixed distance (derived from the current
    //! distance from @a item to @a p.).
    //
    init(weight item:UIDynamicItem, suspendedFromPoint p:CGPoint)
    {
        super.init();
    
        // The high-level pendulum behavior is built from 2 primitive behaviors.
        let gravityBehavior : UIGravityBehavior = UIGravityBehavior(items:[item])
        let attachmentBehavior : UIAttachmentBehavior = UIAttachmentBehavior(item:item, attachedToAnchor:p)
        
        // These primative behaviors allow the user to drag the pendulum weight.
        let draggingBehavior : UIAttachmentBehavior = UIAttachmentBehavior(item:item, attachedToAnchor:CGPointZero)
        let pushBehavior : UIPushBehavior = UIPushBehavior(items:[item], mode:UIPushBehaviorMode.Instantaneous)
        
        pushBehavior.active = false;
        
        self.addChildBehavior(gravityBehavior)
        self.addChildBehavior(attachmentBehavior)
        
        self.addChildBehavior(pushBehavior)
        // The draggingBehavior is added as needed, when the user begins dragging
        // the weight.
        
        self.draggingBehavior = draggingBehavior
        self.pushBehavior = pushBehavior
    }
    
    
    //| ----------------------------------------------------------------------------
    func beginDraggingWeightAtPoint(p:CGPoint)
    {
        self.draggingBehavior.anchorPoint = p
        self.addChildBehavior(self.draggingBehavior)
    }
    
    
    //| ----------------------------------------------------------------------------
    func dragWeightToPoint(p:CGPoint)
    {
        self.draggingBehavior.anchorPoint = p
    }
    
    
    //| ----------------------------------------------------------------------------
    func endDraggingWeightWithVelocity(v:CGPoint)
    {
        var magnitude:CGFloat = sqrtf(powf(v.x, 2.0)+powf(v.y, 2.0));
        let angle:CGFloat = CGFloat(atan2(CDouble(v.y), CDouble(v.x)));
        
        // Reduce the volocity to something meaningful.  (Prevents the user from
        // flinging the pendulum weight).
        magnitude /= 500;
        
        self.pushBehavior.angle = angle;
        self.pushBehavior.magnitude = magnitude;
        self.pushBehavior.active = true;
        
        self.removeChildBehavior(self.draggingBehavior);
    }
    
}

