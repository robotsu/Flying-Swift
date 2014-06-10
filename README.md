Flying-Swift
============

A Swift simple project

Flying-Swift is a open source project developed using iOS Swift
Language, which is released by Apple in WWDC2014 yesterday. Hope you enjoy it and star it, thanks!

Flying-Swift项目是一个纯Swift语言开发的Xcode6, iOS7/8项目，免费下载研究使用，喜欢的请转发并Star一下，谢谢。

History:

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

2014.6.5 Add OPEN SOUSE DEMONSTRATION: 

[JLToast] from SuYeol Jeon

[UITableView-Swift] from YANGReal

2014.6.4 Create this project 

weibo: [@suwei76][1]
blog: [objcc.com][2]

[1]: http://weibo.com/objcc "suwei76"
[2]: http://objcc.com "OBJCC.COM"
[JLToast]: https://github.com/devxoul/JLToast "JLToast"
[UITableView-Swift]: https://github.com/YANGReal/UITableView-Swift "UITableView-Swift"
