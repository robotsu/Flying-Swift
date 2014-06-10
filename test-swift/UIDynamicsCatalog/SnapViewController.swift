//
//  GravityViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-10.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {
    
    @IBOutlet var box1 : UIImageView
    var animator : UIDynamicAnimator?
    //! Reference to the previously applied snap behavior.
    var snapBehavior:UISnapBehavior?
    
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

        let animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view);
        self.animator = animator;
    }
    
    @IBAction func handelSnapGesture(gesture : UITapGestureRecognizer) {
        var point:CGPoint = gesture.locationInView(self.view)
        
        // Remove the previous behavior.
        self.animator!.removeBehavior(self.snapBehavior)
        
        var snapBehavior:UISnapBehavior = UISnapBehavior(item:self.box1, snapToPoint:point)
        self.animator!.addBehavior(snapBehavior)
        
        self.snapBehavior = snapBehavior;
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
