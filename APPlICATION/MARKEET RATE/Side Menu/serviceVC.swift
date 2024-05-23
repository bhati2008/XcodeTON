//
//  serviceVC.swift
//  APPlICATION
//
//  Created by Ashish on 20/05/24.
//

import UIKit
import WebKit

class serviceVC: UIViewController {

    @IBOutlet weak var serviceWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        serviceWebView.load(URLRequest(url: URL(string: "https://clinicbank.tecvertex.com")!))
    }
    

  

}
