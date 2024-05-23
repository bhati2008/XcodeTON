//
//  ViewController.swift
//  APPlICATION
//
//  Created by Ashish on 14/03/24.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var RateBtn: UIControl!{
        didSet{
            RateBtn.layer.cornerRadius = 30
            
        }
    }
    @IBOutlet weak var MarketBtn: UIControl!{
        didSet{
            MarketBtn.layer.cornerRadius = 30
        }
    }
    @IBOutlet weak var FavBtn: UIControl!{
        didSet{
            FavBtn.layer.cornerRadius = 30
        }
    }
    @IBOutlet weak var LogoutBtn: UIControl!{
        didSet{
            LogoutBtn.layer.cornerRadius = 30
        }
    }
    
    
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var MarketPlaceIcon: UIImageView!
    @IBOutlet weak var favourateIcon: UIImageView!
    @IBOutlet weak var logoutIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DashBoard"
        
        configer()
       
      //  self.navigationController?.isNavigationBarHidden = true
//        
        self .navigationItem.setHidesBackButton(true, animated: false)
        
// Change Icon Image Colour
        
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = .systemYellow
        searchIcon.image = searchImage
        
        let MarketImage = UIImage(named: "trade")?.withRenderingMode(.alwaysTemplate)
        MarketPlaceIcon.tintColor = .systemYellow
        MarketPlaceIcon.image = MarketImage
        
        let FavImage = UIImage(named: "favoirt")?.withRenderingMode(.alwaysTemplate)
        favourateIcon.tintColor = .systemYellow
        favourateIcon.image = FavImage
        
        let LogOutImage = UIImage(named: "logout")?.withRenderingMode(.alwaysTemplate)
        logoutIcon.tintColor = .systemYellow
        logoutIcon.image = LogOutImage
        
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
    
    @IBAction func gprate(_ sender: Any) {
        
        
        if let  goReg   = self.storyboard?.instantiateViewController(withIdentifier: "TabbleVC") as?  TabbleVC {
            self.navigationController?.pushViewController(goReg , animated: true)
            print("10")
        }
    }
    
    
    @IBAction func marketBtn(_ sender: Any) {
        if let  GoTradeVC   = self.storyboard?.instantiateViewController(withIdentifier: "ListingTradesVC") as?  ListingTradesVC {
            self.navigationController?.pushViewController(GoTradeVC , animated: true)
            print("10")
        }
        
    }
    
    @IBAction func FavBtn(_ sender: Any) {
        if let  GoTradeVC   = self.storyboard?.instantiateViewController(withIdentifier: "favouriteVC") as?  favouriteVC {
            self.navigationController?.pushViewController(GoTradeVC , animated: true)
            print("10")
        }
    }
    
    @IBAction func LogoutBtn(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "isLogin")
        if let  GoLogin   = self.storyboard?.instantiateViewController(withIdentifier: "PhoneViewController") as?  PhoneViewController {
            self.navigationController?.pushViewController(GoLogin , animated: true)
        }
        
    }
    
   
    @IBAction func favTabBtn(_ sender: Any) {
        if let  goFav   = self.storyboard?.instantiateViewController(withIdentifier: "favouriteVC") as?  favouriteVC {
            self.navigationController?.pushViewController(goFav , animated: true)
        }

    }
  
    @IBAction func itemTabBtn(_ sender: Any) {
        if let  goItem   = self.storyboard?.instantiateViewController(withIdentifier: "TabbleVC") as?  TabbleVC {
            self.navigationController?.pushViewController(goItem , animated: true)
        }
    }
   
    @IBAction func homeTabBtn(_ sender: Any) {
        if let  goHome   = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as?  ViewController {
            self.navigationController?.pushViewController(goHome , animated: true)
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
