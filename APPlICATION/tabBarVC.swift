//
//  tabBarVC.swift
//  APPlICATION
//
//  Created by Ashish on 26/03/24.
//

import UIKit
import SideMenu

class tabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        title = "DashBoard"
        
        configer()
    }
    
    func configer (){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(SideMenuBtn))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    //    @objc func SideMenuBtn(){
    //        if let  gofav = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as?  SideMenuNavigationController {
    //            self.navigationController?.pushViewController(gofav, animated: true)
    //        }
    //
    //    }
    
    //}
    @objc func SideMenuBtn() {
        performSegue(withIdentifier: "ShowSideMenu", sender: self)
        
    }
}
