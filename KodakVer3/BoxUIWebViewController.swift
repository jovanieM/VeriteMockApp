//
//  BoxUIWebViewController.swift
//  KodakVer3
//
//  Created by jmolas on 4/21/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import WebKit

class BoxUIWebViewController: UIViewController, WKNavigationDelegate{
    
    var webView : WKWebView!

    var urlString : String!
    //var vc = UINavigationController()
 
    
//    @IBAction func cancel(_ sender: Any) {
//        self.navigationController?.dismiss(animated: true, completion: nil)
//    }
    var activity : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: url)
        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
        let rightButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel1))
        self.navigationItem.rightBarButtonItem = rightButton
        activity = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activity.hidesWhenStopped = true
        activity.color = .gray
        activity.center = self.view.center
        self.view.addSubview(activity)
        
        //self.navigationController?.navigationItem.rightBarButtonItem = rightButton
        //vc.navigationItem.rightBarButtonItem = rightButton
        
        
    }
    
    func cancel1(){
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start to load")
        activity.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        activity.stopAnimating()
        
    }

  


}
