//
//  PrivacyPolicyVC.swift
//  APPlICATION
//
//  Created by Ashish on 08/05/24.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: URL(string: privacPolicy)!))
    }
    


}
