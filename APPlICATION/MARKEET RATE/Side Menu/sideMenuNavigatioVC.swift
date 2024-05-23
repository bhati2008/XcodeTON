//
//  sideMenuNavigatioVC.swift
//  APPlICATION
//
//  Created by Ashish on 01/05/24.
//

import UIKit


class sideMenuNavigatioVC: UIViewController {

    @IBOutlet weak var home : UIControl!{
        didSet{
            home.layer.borderWidth = 2
            home.layer.borderColor = UIColor.systemYellow.cgColor
            
        }
    }
    
    @IBOutlet weak var CreateNewList : UIControl!{
        didSet{
            CreateNewList.layer.borderWidth = 2
            CreateNewList.layer.borderColor = UIColor.systemYellow.cgColor
            
        }
    }
    @IBOutlet weak var MyList : UIControl!{
        didSet{
            MyList.layer.borderWidth = 2
            MyList.layer.borderColor = UIColor.systemYellow.cgColor
            
        }
    }
    @IBOutlet weak var closeListing : UIControl!{
        didSet{
            closeListing.layer.borderWidth = 2
            closeListing.layer.borderColor = UIColor.systemYellow.cgColor
            
        }
    }
    
    @IBOutlet weak var bidsPlaced: UIControl!{
        didSet{
            bidsPlaced.layer.borderWidth = 2
            bidsPlaced.layer.borderColor = UIColor.systemYellow.cgColor
            
        }
    }
    
    @IBOutlet weak var marketRate: UIControl!{
        didSet{
            marketRate.layer.borderWidth = 2
            marketRate.layer.borderColor = UIColor.systemYellow.cgColor
            
        }
    }
    
    @IBOutlet weak var favTrades: UIControl!{
        didSet{
            favTrades.layer.borderWidth = 2
            favTrades.layer.borderColor = UIColor.systemYellow.cgColor
            
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "DashBoard"
//        let Home = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
//        homeimg.tintColor = .black
//        homeimg.image = Home

    }
    
    

    @IBAction func homeBtn(_ sender: Any) {
        if let  Home   = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as?  tabBarVC {
            self.navigationController?.pushViewController(Home , animated: true)
        }
    }
    
    @IBAction func createListBtn(_ sender: Any) {
        if let  CreateList   = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as?  tabBarVC {
            self.navigationController?.pushViewController(CreateList , animated: true)
        }
    }
    
    @IBAction func myListBtn(_ sender: Any) {
    }
    
    @IBAction func closingListBtn(_ sender: Any) {
    }
    
    @IBAction func bidsPlacedBtn(_ sender: Any) {
        if let  bidsPlaced   = self.storyboard?.instantiateViewController(withIdentifier: "myBidListing") as? myBidListing  {
            self.navigationController?.pushViewController(bidsPlaced , animated: true)
        }
    }
    @IBAction func marketRateBtn(_ sender: Any) {
        if let  MarketRate   = self.storyboard?.instantiateViewController(withIdentifier: "TabbleVC") as? TabbleVC  {
            self.navigationController?.pushViewController(MarketRate , animated: true)
        }
    }
    
    @IBAction func favTradesBtn(_ sender: Any) {
        if let  Favtrade   = self.storyboard?.instantiateViewController(withIdentifier: "favouriteVC") as?  favouriteVC {
            self.navigationController?.pushViewController(Favtrade , animated: true)
        }
    }
    
    
    //Bottam Batan
    
    @IBAction func profie(_ sender: Any) {
        UIApplication.shared.open(URL(string: Aboutus)!)
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
    }
    
}





