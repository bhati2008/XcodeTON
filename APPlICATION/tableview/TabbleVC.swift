//
//  TabbleVC.swift
//  APPlICATION
//
//  Created by Ashish on 28/03/24.
//

import UIKit
import Charts
import SideMenu

//var tradeData = RateDataList

 
class TabbleVC: UIViewController {
var RateDataList : Array<BrateResponse> = Array()
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var FileLabel: UILabel!
    
    @IBOutlet var myTable:UITableView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        FileLabel.layer.masksToBounds = true
        FileLabel.layer.cornerRadius = 10
        
         RateIconFunc()
        
    }
    
    
 
    func RateIconFunc() {
        let url = RateIcon
        
        let rateUrl = URL(string: url)!
        
        var request = URLRequest(url: rateUrl)
        request.httpMethod = "post"
        
        
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            
            if statusCode == 200 {
                print( "SUCCESS")
                
                
                
                debugPrint(response ?? "no response")
                
                guard let data = data else  {
                    print("request failed \(String(describing: error))")
                    return
                }
                
                
                do {
                    let rateResponse = try JSONDecoder().decode(BrateResponseArray.self, from: data)
                    print("rateResponse = \(rateResponse)")
                    debugPrint(rateResponse)
                    
                    
                    self.RateDataList = rateResponse.value
                    
                    print("self.RateDataList = \(self.RateDataList)")
                    

                    DispatchQueue.main.async { self.myTable.reloadData()
                        
                    }
                    
                    
                    
                }
                catch {
                    print("Error: \(error)")
                }
                
                
                
            } else {
                print("FAILURE")
                
                debugPrint( "FAILURE")
                
            }
        }
        task.resume()
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
    extension TabbleVC : UITableViewDelegate,UITableViewDataSource{
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return RateDataList.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RateCell
            cell.textLabel?.text = RateDataList[indexPath.row].tradeName
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if let  getOTPVC  = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as?  HomeController {
                
                let tradeid =  RateDataList[indexPath.row].trade_id
                let fileName = RateDataList[indexPath.row].tradeName

                print("subtrade id is == \(tradeid)")
                
                  getOTPVC.trade_id = tradeid
                  getOTPVC.SubTradename = (" \(fileName) ")

                
                self.navigationController?.pushViewController(getOTPVC, animated: true)
                
                
            }
            
    
//
//            myTable.deselectRow(at: indexPath, animated: true)
//            performSegue(withIdentifier: "home", sender: self)
            
        }
        
        
    }


struct BrateResponse : Codable {
    
   let trade_id: Int
   let tradeName: String
   let tradeType: String
   let status: String
    
    }
struct BrateResponseArray : Codable {
    
   let value: Array<BrateResponse>
    
    
    }
