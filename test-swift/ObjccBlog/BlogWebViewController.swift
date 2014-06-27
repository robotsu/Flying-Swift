//
//  BlogWebViewController.swift
//  test-swift
//
//  Created by Su Wei on 14-6-27.
//  Copyright (c) 2014年 OBJCC.COM. All rights reserved.
//

import UIKit

class BlogWebViewController: UIViewController, UIWebViewDelegate {
    
    let webview = UIWebView()

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view = webview
        webview.delegate = self
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
    
    func loadUrl(string urlString: String) {
        let url = NSURL(string:urlString)
        let request: NSURLRequest = NSURLRequest(URL: url)
        webview.loadRequest(request)
    }
    
    func webViewDidStartLoad(webView:UIWebView) {
        let actInd = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.White)
        let actItem = UIBarButtonItem(customView:actInd)
        self.navigationItem.rightBarButtonItem = actItem
        actInd.startAnimating()
    }
    
    func webViewDidFinishLoad(webView:UIWebView) {
        self.navigationItem.rightBarButtonItem = nil
    }
}
