//
//  aboutusVC.swift
//  APPlICATION
//
//  Created by Ashish on 07/05/24.
//

import UIKit
import WebKit

class aboutusVC: UIViewController {

   
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: URL(string: Aboutus)!))
    }


}
