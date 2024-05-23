//
//  GetSubGradeFromRateVC.swift
//  APPlICATION
//
//  Created by Ashish on 29/03/24.
//

import UIKit

class GetSubGradeFromRateVC: UIViewController {
   
    var SubGradeDataList : Array<GetSubGrade> = Array()
    
    var trade_id  = 0
    var tradeSub_id  = 0
    @IBOutlet weak var GradeFileLbl: UILabel!
    
    @IBOutlet weak var SubGradeTable: UITableView!
     var Gradename = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configer ()
        
        GradeFileLbl.layer.masksToBounds = true
        GradeFileLbl.layer.cornerRadius = 10
        print(" gradelist = \(SubGradeDataList)")
        
        GradeFileLbl.text = Gradename
        
        let url = SubGrade
        
        let SubGrade = URL(string: url)!
        
        var request = URLRequest(url: SubGrade)
        request.httpMethod = "post"
        
        let subGradePayLoad = SubGradePayLoad(trade_id:trade_id, tradeSub_id:tradeSub_id)
        
        print("Boady \(subGradePayLoad)" )
        debugPrint("Boady \(subGradePayLoad)")

        let data = try! JSONEncoder().encode(subGradePayLoad)

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
                    let SubGraderateResponse = try JSONDecoder().decode(SubGradeResponse.self, from: data)
                    print(SubGraderateResponse)
                    
                    self.SubGradeDataList = SubGraderateResponse.value
                    
                    DispatchQueue.main.async { self.SubGradeTable.reloadData() }
                    
                    
                    
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




extension GetSubGradeFromRateVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubGradeDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subGradeCell = SubGradeTable.dequeueReusableCell(withIdentifier: "subGradeCell", for: indexPath)
        subGradeCell.textLabel?.text = SubGradeDataList[indexPath.row].trade_grade

        return subGradeCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let  goTradeMarket = self.storyboard?.instantiateViewController(withIdentifier: "GetTradeMarketVC") as?  GetTradeMarketVC {
//
//            let tradeSub_id =  SubTradeDataList[indexPath.row].id
              let tradeGrade_id =  SubGradeDataList[indexPath.row].gradeID
            let fileName = SubGradeDataList[indexPath.row].trade_grade

            goTradeMarket.subTrade_id = tradeSub_id
            goTradeMarket.trades_id = trade_id
            goTradeMarket.tradeGrade_id = tradeGrade_id
            
            goTradeMarket.Marketname = ("\(Gradename) ->\(fileName)")
            
           
            self.navigationController?.pushViewController(goTradeMarket, animated: true)
            
            
        }
    }

    

}

struct SubGradePayLoad: Encodable {
    
    let trade_id:Int
    let tradeSub_id:Int
    
}

struct SubGradeResponse : Codable {
    
   let value: Array<GetSubGrade>
    let successful:Bool
    let message:String
    
    
    
    }

struct GetSubGrade : Codable {
    
    let trade_ID:Int
    let trade_Name:String
    let trade_Sub_type_ID:Int
    let trade_Sub_type_NAme:String
    let trade_grade:String
    let status:String
    let gradeID:Int
    
}


 

