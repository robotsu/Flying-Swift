//
//  ViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-4.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet var swiftImg : UIImageView
    @IBOutlet var hiButton : UIButton
    @IBAction func hiButtonClicked(sender : AnyObject) {
        fly()
        hiButton.hidden = true
    }
    
    func fly() {
        let thePath:CGMutablePathRef = CGPathCreateMutable();
        CGPathMoveToPoint(thePath,nil,74.0,74.0);
        CGPathAddCurveToPoint(thePath,nil,74.0,300.0,
            230.0,300.0,
            230.0,74.0);
        
        // Create the animation object, specifying the position property as the key path.
        let theAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position");
        theAnimation.path=thePath;
        theAnimation.duration=5.0;
        theAnimation.rotationMode = "auto"
        theAnimation.repeatCount = 9999999
        theAnimation.delegate = self
        
        // Add the animation to the layer.
        swiftImg.layer.addAnimation(theAnimation, forKey:"position");

    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool){
        hiButton.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hiButton.setTitle("Click to fly", forState:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

