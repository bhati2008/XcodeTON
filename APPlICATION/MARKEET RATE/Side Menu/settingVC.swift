//
//  settingVC.swift
//  APPlICATION
//
//  Created by Ashish on 07/05/24.
//

import UIKit

class settingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func contactBtn(_ sender: Any) {
        
        if let  contactUs = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as?  ContactUsVC {
            self.navigationController?.pushViewController(contactUs, animated: true)
        }
    }
    @IBAction func aboutUsBtn(_ sender: Any) {
        if let  about = self.storyboard?.instantiateViewController(withIdentifier: "aboutusVC") as?  aboutusVC {
            self.navigationController?.pushViewController(about, animated: true)
        }
    }
    
    @IBAction func servicesBtn(_ sender: Any) {
        if let  service = self.storyboard?.instantiateViewController(withIdentifier: "serviceVC") as?  serviceVC {
            self.navigationController?.pushViewController(service, animated: true)
        }
    }
    
    @IBAction func PrivacyBtn(_ sender: Any) {
        if let  Privacy = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as?  PrivacyPolicyVC {
            self.navigationController?.pushViewController(Privacy, animated: true)
        }
    }
    
    @IBAction func homeTabBtn(_ sender: Any) {
        if let  goHome   = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as?  ViewController {
            self.navigationController?.pushViewController(goHome , animated: true)
        }
    }
    
    @IBAction func itemTabBtn(_ sender: Any) {
        if let  goItem   = self.storyboard?.instantiateViewController(withIdentifier: "TabbleVC") as?  TabbleVC {
            self.navigationController?.pushViewController(goItem , animated: true)
        }
    }
    
    
    @IBAction func favTabBtn(_ sender: Any) {
        if let  goFav   = self.storyboard?.instantiateViewController(withIdentifier: "favouriteVC") as?  favouriteVC {
            self.navigationController?.pushViewController(goFav , animated: true)
        }

    }
  
    
    @IBAction func marketTabBtn(_ sender: Any) {
        if let  goMarket   = self.storyboard?.instantiateViewController(withIdentifier: "ListingTradesVC") as?  ListingTradesVC {
            self.navigationController?.pushViewController(goMarket , animated: true)
        }
    }
    
    @IBAction func settingTabBtn(_ sender: Any) {
        if let  goSetting   = self.storyboard?.instantiateViewController(withIdentifier: "settingVC") as?  settingVC {
            self.navigationController?.pushViewController(goSetting , animated: true)
        }
    }
}
