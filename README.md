Flying-Swift
============

Description:
-------------

Flying-Swift is a fun open source project developed using Apple's Swift
Language, which is released the day after Apple's WWDC2014 Swift distribution day. Hope you enjoy it it, thanks!


BUILD REQUIREMENTS:
-------------

iOS 8.0 SDK or later
 

RUNTIME REQUIREMENTS:
-------------

iOS 7.0 or later


PACKAGING LIST:
-------------

### Apple's UIKit Dynamic Catalogs Migration to Swift ######

*  GravityViewController.swift
*  CollisionGravityViewController.swift
*  AttachmentViewController.swift
*  CollisionsGravitySpringViewController.swift
*  SnapViewController.swift
*  ContinuousPushViewController.swift
*  InstantaneousPushViewController.swift
*  ItemPropertiesViewController.swift
*  CustomDynamicViewController.swift
*  CompositeBehaviorViewController.swift
*  UIDCPendulumBehavior.swift
*  UIDCDecorationView.swift
*  UIDCPositionToBoundsMapping.swift


### Blog site: blog.objcc.com 's web client ######

*  BlogViewController.swift
*  BlogTableViewCell.swift
*  UIImageView+WebCache.swift


SNAPSHOT:
-------------

![Flying Swift Cover Page](http://blog.objcc.com/wp-content/uploads/2014/06/flying-swift-intro-5-191x300.png)
![Objcc.com Blog Client](http://blog.objcc.com/wp-content/uploads/2014/06/flying-swift-intro-4-191x300.png)

![Dynamics Catalog: Pendulum](http://blog.objcc.com/wp-content/uploads/2014/06/flying-swift-intro-3-191x300.png)
![Dynamics Catalog: Instantaneous Push + Collision](http://blog.objcc.com/wp-content/uploads/2014/06/flying-swift-intro-3-191x300.png)

![Dynamics Catalog: Attachments + Collision](http://blog.objcc.com/wp-content/uploads/2014/06/flying-swift-intro-3-191x300.png)


HISTORY:
-------------
2014.6.21 Add Snapshots and update readme.

2014.6.20 Add Pull to refresh to BlogViewController and load blogs image from my site: http://blog.objcc.com

2014.6.19 Add BlogViewController etc. to read blogs titles from my site: http://blog.objcc.com

2014.6.14 Add CollisionsGravitySpringViewController which is a little
different from the apple's, just for fun.

2014.6.13 Add UIDCPendulumBehavior, CompositeBehaviorViewController, to avoid the bug happened in AttachmentViewController, I changed to add UIImageViews by code not by IB, it works.

2014.6.12 Add AttachmentViewController but maybe found an ios8 beta's bug, read the source please.

2014.6.11 Add CustomDynamicItemViewController etc.

2014.6.10 Add ItemPropertiesViewController, InstantaneousPushViewController, ContinuousPushViewController etc.

2014.6.9 Change layout compatible with "wAny hAny" class; Since apple has distrubuted "Creating and Customizing UIKit Controls in Swift" samples recently, so I do not need to translate more, you can find the sample on apple's developer site, Thanks.

2014.6.8 Maybe I found a xcode6 beta(ios8 beta)'s bug when I add a control into a Table View's Static Cell Content View, the steps are: 

    1.New a project (master detail template); 

    2.Open storyboard, change Layout: wCompact hAny; 

    3.Change Table View with Static Cells; 

    4.Add any control such as an Activity Indicator in to the Table View;

    5.Cell's Content View, and add New Alignment Constrains: Horizontal Center in Container and Vertical Center in Container;

    6.Run the App: The bug is you will not see the Activity Indicator or any control you just added just now.

    However if you select wAny hAny layout first, the control (Activity Indicator, any) can be shown as we expect.

2014.6.7 Add apples UIKit Dynamic Catagory: CollisionGravityViewController.

2014.6.6 Add apples UICategory and UIKit Dynamic Catagory, still working on it.

2014.6.5 Using OPEN SOUSE JLToast to show Android like Toast alert
message: 

[JLToast] from SuYeol Jeon

2014.6.4 Create this project 

weibo: [@suwei76][1]
blog: [objcc.com][2]

[1]: http://weibo.com/objcc "suwei76"
[2]: http://objcc.com "OBJCC.COM"
[JLToast]: https://github.com/devxoul/JLToast "JLToast"
