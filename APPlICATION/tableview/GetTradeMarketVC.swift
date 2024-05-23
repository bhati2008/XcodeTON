//
//  GetTradeMarketVC.swift
//  APPlICATION
//
//  Created by Ashish on 29/03/24.
//

import UIKit
import Charts


class GetTradeMarketVC: UIViewController {
    
    
    
    var GetMarketDataList : Array<GetMarket> = Array()
    
    
    
    var trades_id  = 0
    var subTrade_id  = 0
    var tradeGrade_id = 0

    
    @IBOutlet weak var TradeFileLbl: UILabel!
    @IBOutlet weak var SubTradeMarketTable: UITableView!
    
    var Marketname = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configer ()
        
        TradeFileLbl.layer.masksToBounds = true
        TradeFileLbl.layer.cornerRadius = 10
        
        TradeFileLbl.text = Marketname
       
//        let marketData = MarketData(Rate: 0, createddta: "")
         
        print(" GetMarketDataList  = \(GetMarketDataList)")
        
        let url = SubTradeMarket
        
        let tradeMarket = URL(string: url)!
        
        var request = URLRequest(url: tradeMarket)
        request.httpMethod = "POST"
        
        let marketPayLoad = MarketPayLoad(trades_id: trades_id, subTrade_id: subTrade_id, tradeGrade_id: tradeGrade_id)
        
        print("Boady \(marketPayLoad)" )
        debugPrint("Boady \(marketPayLoad)")
         

        let data = try! JSONEncoder().encode(marketPayLoad)
        
        request.httpBody = data
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
            )
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            debugPrint(statusCode)
            debugPrint("DATA Boady = \(String(describing: data))")
            
            
            
            if statusCode == 200 {
                print( "SUCCESS")
                
                
                
                debugPrint(response ?? "no response")
                
                guard let data = data else  {
                    print("request failed \(String(describing: error))")
                    return
                }
                
 
                do {
                    let GetMarketResponse = try JSONDecoder().decode(GetMarketResponse.self, from: data)
                    print(GetMarketResponse)
                    
                    self.GetMarketDataList = GetMarketResponse.value
                    
                    DispatchQueue.main.async { self.SubTradeMarketTable.reloadData() }
                    
                    
                    
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
    
    func configer (){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(SideMenuBtn))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc func SideMenuBtn() {
        performSegue(withIdentifier: "ShowSideMenu", sender: self)
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



extension GetTradeMarketVC: UITableViewDelegate,UITableViewDataSource{

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return GetMarketDataList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let GetMarketCell = SubTradeMarketTable.dequeueReusableCell(withIdentifier: "GetMarketCell", for: indexPath) as! TradeMarketCell
         let MarketRate =  GetMarketDataList[indexPath.row].rate
         
        GetMarketCell.textLabel?.text = GetMarketDataList[indexPath.row].market_name
         GetMarketCell.RateLabel.text = "\(MarketRate)"
         GetMarketCell.DateLabel.text = GetMarketDataList[indexPath.row].created_dt
         
         


        return GetMarketCell
         
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let  gorateGraph = self.storyboard?.instantiateViewController(withIdentifier: "rateGraphTradewiseVC") as?  rateGraphTradewiseVC {
//
//            let tradeSub_id =  SubTradeDataList[indexPath.row].id
              let tradeGrade_id =  GetMarketDataList[indexPath.row].tradeGrade_id
            let market_id = GetMarketDataList[indexPath.row].market_ID
            let marketRate = GetMarketDataList[indexPath.row].rate
          

           
            gorateGraph.market_id = market_id
            gorateGraph.trade_id = trades_id
            gorateGraph.subTrade_id = subTrade_id
            gorateGraph.trade_grade_id = tradeGrade_id
            
          
            
           
            self.navigationController?.pushViewController(gorateGraph, animated: true)
            
            
        }
    }


}


struct MarketPayLoad: Encodable {

    let trades_id:Int
    let subTrade_id:Int
    let tradeGrade_id:Int
}


struct GetMarketResponse : Codable {

   let value: Array<GetMarket>
    let message:String
    let successful:Bool


    }

struct GetMarket : Codable {

    let market_ID:Int
    let market_name:String
    let state:String
    let city:String
    let pincode:Int
    let latitude:String?
    let longitude:String?
    let status:String
    let created_dt:String
    let cr_By:String
    let trades_id:Int
    let subTrade_id:Int
    let tradeGrade_id:Int
    let tradeName:String
    let subtradeName:String
    let tradeGradeName:String
    let rate:Int
    let updatedate:String
}
