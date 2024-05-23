//
//  HomeController.swift
//  APPlICATION
//
//  Created by Ashish on 28/03/24.
//

import UIKit
import SideMenu

class HomeController: UIViewController {
   
    var SubTradeDataList : Array<SubTradeResponse> = Array()
    
    var trade_id  = 0
    
    var SubTradename = ""
    
    @IBOutlet weak var fileLbl: UILabel!
    
    @IBOutlet weak var SubTradeTable: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        configer ()


        fileLbl.layer.masksToBounds = true
        fileLbl.layer.cornerRadius = 10
        
        fileLbl.text = SubTradename
        
        let url = SubTrade
        
        let SubTrade = URL(string: url)!
        
        var request = URLRequest(url: SubTrade)
        request.httpMethod = "post"
        
        let subTradePayLoad = SubTradePayLoad(trade_id:trade_id )
        
        let data = try! JSONEncoder().encode(subTradePayLoad)
        
        request.httpBody = data
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            debugPrint(statusCode)
            
            
            
            if statusCode == 200 {
                print( "SUCCESS")
                
                
                
                debugPrint(response ?? "no response")
                
                guard let data = data else  {
                    print("request failed \(String(describing: error))")
                    return
                }
                
                
                do {
                    let SubTraderateResponse = try JSONDecoder().decode(SubTradeResponseArray.self, from: data)
                    print(SubTraderateResponse)
                  //  debugPrint(SubTraderateResponse)
                    
                    self.SubTradeDataList = SubTraderateResponse.value
 
                    DispatchQueue.main.async { self.SubTradeTable.reloadData() }
                    
                    
                    
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
  


extension HomeController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubTradeDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subTradeCell = SubTradeTable.dequeueReusableCell(withIdentifier: "subTradeCell", for: indexPath)
        subTradeCell.textLabel?.text = SubTradeDataList[indexPath.row].trade_Sub_Type
        
        return subTradeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let  goSubGrade = self.storyboard?.instantiateViewController(withIdentifier: "GetSubGradeFromRateVC") as?  GetSubGradeFromRateVC {
            
            let tradeSub_id =  SubTradeDataList[indexPath.row].id
            let trade_id =  SubTradeDataList[indexPath.row].tradeID
            let fileName = SubTradeDataList[indexPath.row].trade_Sub_Type
      
            goSubGrade.tradeSub_id = tradeSub_id
            goSubGrade.trade_id = trade_id
            goSubGrade.Gradename =  (" \(SubTradename)-> \(fileName)")
           
            self.navigationController?.pushViewController(goSubGrade, animated: true)
            
            
        }
    }
}

struct SubTradePayLoad: Encodable {

    let trade_id: Int

}
struct SubTradeResponse : Codable {
    
   let id: Int
   let subTradeID: Int
   let tradeID: Int
   let tradeName: String
   let trade_Sub_Type: String
   let status: String
   let update_Rate: String
    
    }
struct SubTradeResponseArray : Codable {
    
   let value: Array<SubTradeResponse>
    
    
    }
