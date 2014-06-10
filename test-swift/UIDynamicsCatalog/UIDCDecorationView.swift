//
//  UIDCDecorationView.swift
//  test-swift
//
//  Created by Su Wei on 14-6-8.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit
import QuartzCore


class UIDCDecorationView: UIView {
    
    var attachmentPointView:UIView?
    var attachedView:UIView?
    var attachmentOffset:CGPoint?
    //! Array of CALayer objects, each with the contents of an image
    //! for a dash.
    var attachmentDecorationLayers:NSMutableArray?
    
    @IBOutlet var centerPointView : UIImageView
    var arrowView:UIImageView?
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(patternImage:UIImage(named: "BackgroundTile"))
    }

    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    //| ----------------------------------------------------------------------------
    //! Draws an arrow with a given @a length anchored at the center of the receiver,
    //! that points in the direction given by @a angle.
    //
    func drawMagnitudeVector(length:CGFloat, angle:CGFloat, color arrowColor:UIColor, forLimitedTime temporary:Bool)
    {
        if (!self.arrowView)
        // First time initialization.
        {
            var arrowImage:UIImage = UIImage(named:"Arrow").imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);
            
            var arrowImageView:UIImageView = UIImageView(image:arrowImage);
            arrowImageView.bounds = CGRectMake(0, 0, arrowImage.size.width, arrowImage.size.height);
            arrowImageView.contentMode = UIViewContentMode.Right;
            arrowImageView.clipsToBounds = true;
            arrowImageView.layer.anchorPoint = CGPointMake(0.0, 0.5);
            
            self.addSubview(arrowImageView);
            self.sendSubviewToBack(arrowImageView);
            self.arrowView = arrowImageView;
        }
        
        self.arrowView!.bounds = CGRectMake(0, 0, length, self.arrowView!.bounds.size.height);
        self.arrowView!.transform = CGAffineTransformMakeRotation(angle);
        self.arrowView!.tintColor = arrowColor;
        self.arrowView!.alpha = 1;
        
        if (temporary){
            UIView.animateWithDuration(1.0, animations:{
                self.arrowView!.alpha = 0;
            });
        }
    }
    
    //| ----------------------------------------------------------------------------
    //! Draws a dashed line between @a attachmentPointView and @a attachedView
    //! that is updated as either view moves.
    //
    func trackAndDrawAttachmentFromView(attachmentPointView:UIView, toView attachedView:UIView, withAttachmentOffset attachmentOffset:CGPoint)
    {
        if (!self.attachmentDecorationLayers)
        // First time initialization.
        {
            self.attachmentDecorationLayers = NSMutableArray(capacity:4)
            for (var i=0; i<4; i++)
            {
                var dashImage:UIImage = UIImage(named:NSString(format:"DashStyle%i", (i % 3) + 1))
                var dashLayer:CALayer = CALayer()
                dashLayer.contents = dashImage.CGImage
                dashLayer.bounds = CGRectMake(0, 0, dashImage.size.width, dashImage.size.height)
                dashLayer.anchorPoint = CGPointMake(0.5, 0)
        
                self.layer.insertSublayer(dashLayer, atIndex:0)
                self.attachmentDecorationLayers!.addObject(dashLayer)
            }
        }
        
        // A word about performance.
        // Tracking changes to the properties of any id<UIDynamicItem> involved in
        // a simulation incurs a performance cost.  You will receive a callback
        // during each step in the simulation in which the tracked item is not at
        // rest.  You should therefore strive to make your callback code as
        // efficient as possible.
        
        //self.attachmentPointView!.removeObserver(self, forKeyPath:"center", context:nil)
        //self.attachedView!.removeObserver(self, forKeyPath:"center", context:nil)
        
        self.attachmentPointView = attachmentPointView
        self.attachedView = attachedView
        self.attachmentOffset = attachmentOffset
        
        // Observe the 'center' property of both views to know when they move.
        self.attachmentPointView!.addObserver(self, forKeyPath:"center", options:NSKeyValueObservingOptions(0), context:nil)
        self.attachedView!.addObserver(self, forKeyPath:"center", options:NSKeyValueObservingOptions(0), context:nil)
        
        self.setNeedsLayout();
    }
    
    
    //| ----------------------------------------------------------------------------
    override func layoutSubviews()
    {
        super.layoutSubviews();
        
        if(self.arrowView){
            self.arrowView!.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        }
        
        if (self.centerPointView){
            self.centerPointView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        }
        
        if (self.attachmentDecorationLayers)
        {
            // Here we adjust the line dash pattern visualizing the attachement
            // between attachmentPointView and attachedView to account for a change
            // in the position of either.
        
            let MaxDashes = self.attachmentDecorationLayers!.count;
        
            var attachmentPointViewCenter:CGPoint = CGPointMake(self.attachmentPointView!.bounds.size.width/2, self.attachmentPointView!.bounds.size.height/2)
            attachmentPointViewCenter = self.attachmentPointView!.convertPoint(attachmentPointViewCenter, toView:self)
            
            var attachedViewAttachmentPoint:CGPoint = CGPointMake(self.attachedView!.bounds.size.width/2 + self.attachmentOffset!.x, self.attachedView!.bounds.size.height/2 + self.attachmentOffset!.y)
            
            attachedViewAttachmentPoint =  self.attachedView!.convertPoint(attachedViewAttachmentPoint, toView:self)
            
            var distance:CGFloat = sqrtf( powf(attachedViewAttachmentPoint.x-attachmentPointViewCenter.x, 2.0) +
            powf(attachedViewAttachmentPoint.y-attachmentPointViewCenter.y, 2.0) )
            
            var angle:CDouble = atan2( Double(attachedViewAttachmentPoint.y - attachmentPointViewCenter.y), Double(attachedViewAttachmentPoint.x - attachmentPointViewCenter.x))
            
            var requiredDashes = 0;
            var d:CGFloat = 0.0;
        
            // Depending on the distance between the two views, a smaller number of
            // dashes may be needed to adequately visualize the attachment.  Starting
            // with a distance of 0, we add the length of each dash until we exceed
            // 'distance' computed previously or we use the maximum number of allowed
            // dashes, 'MaxDashes'.
            while (requiredDashes < MaxDashes)
            {
                var dashLayer:CALayer = self.attachmentDecorationLayers![requiredDashes] as CALayer
            
                
                if (d + dashLayer.bounds.size.height < distance) {
                    d += dashLayer.bounds.size.height;
                    dashLayer.hidden = false;
                    requiredDashes++;
                } else {
                    break;
                }
            }
        
            // Based on the total length of the dashes we previously determined were
            // necessary to visualize the attachment, determine the spacing between
            // each dash.
            var dashSpacing:CGFloat = (distance - d) / CGFloat(requiredDashes + 1) ;
        
            // Hide the excess dashes.
            while (requiredDashes < MaxDashes){
                requiredDashes++
                (self.attachmentDecorationLayers![requiredDashes] as CALayer).hidden=true
            }
            // Disable any animations.  The changes must take full effect immediately.
            CATransaction.begin();
            CATransaction.setAnimationDuration(0);
        
            // Each dash layer is positioned by altering its affineTransform.  We
            // combine the position of rotation into an affine transformation matrix
            // that is assigned to each dash.
            var transform:CGAffineTransform = CGAffineTransformMakeTranslation(attachmentPointViewCenter.x, attachmentPointViewCenter.y)
            
            transform = CGAffineTransformRotate(transform, CGFloat(angle - M_PI/2))
            
            for (var drawnDashes = 0; drawnDashes < requiredDashes; drawnDashes++)
            {
                var dashLayer:CALayer = self.attachmentDecorationLayers![drawnDashes] as CALayer;
                
                transform = CGAffineTransformTranslate(transform, 0, dashSpacing);
                
                dashLayer.setAffineTransform(transform);
                
                transform = CGAffineTransformTranslate(transform, 0, dashLayer.bounds.size.height);
            }
            
            CATransaction.commit();
        }
    }

    
    
    //| ----------------------------------------------------------------------------

    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: NSDictionary!, context: CMutableVoidPointer)
    {
        if (object as NSObject == self.attachmentPointView! || object as NSObject == self.attachedView!)
        {
            self.setNeedsLayout()
        }
        else
        {
            super.observeValueForKeyPath(keyPath, ofObject:object, change:change, context:context)
        }
    }
    
    //| ----------------------------------------------------------------------------
    deinit
    {
        self.attachmentPointView?.removeObserver(self, forKeyPath:"center")
        self.attachedView?.removeObserver(self, forKeyPath:"center")
    }

}
