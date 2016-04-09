//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Ivan Cai on 1/30/16.
//  Copyright © 2016 Ivan Cai. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    var webView: WKWebView!
    override func loadView() {
        webView = WKWebView()
        view = webView
        let url = NSURL(string: "https://www.bignerdranch.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
}