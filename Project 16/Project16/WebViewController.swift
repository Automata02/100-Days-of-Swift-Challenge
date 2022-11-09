//
//  WebViewController.swift
//  Project16
//
//  Created by Roberts Kursitis on 17/05/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var website: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard website != nil else {
            return
        }
        if let url = URL(string: website) {
            webView.load(URLRequest(url: url))
        }

    }
    
}
