//
//  CustomSplshScreenViewController.swift
//  APPlICATION
//
//  Created by Ashish on 26/03/24.
//

import UIKit

class CustomSplshScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        


        let vrylogin = UserDefaults.standard.bool(forKey: "isLogin")

        if(vrylogin){
            print("isLogin TRUE")
        }else{
            print("isLogin Failse")
        }

        if (vrylogin == true ){
            if let  gohome  = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as?  ViewController {
                self.navigationController?.pushViewController(gohome, animated: true)
            }
        }else{
            if let  goLogin  = self.storyboard?.instantiateViewController(withIdentifier: "PhoneViewController") as?  PhoneViewController {
                self.navigationController?.pushViewController(goLogin, animated: true)
            }

            print("to login scrren")
        }
        
    }
   
    }

