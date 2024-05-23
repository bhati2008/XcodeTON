//
//  favouriteVC.swift
//  APPlICATION
//
//  Created by Ashish on 24/04/24.
//

import UIKit
import Charts

class favouriteVC: UIViewController {
    
    var market_id = 0
    var trade_ID = 0
    var sub_trade_id = 0
    var trade_grade = 0
     
     var indexForFavGraphList=0
    
    
    
    var getFavList :Array<favDetail> = Array()
    var GetFaveGraphList : Array<favRateGraph> = Array()
    
    
    @IBOutlet weak var favTableView: UITableView!
    
    var selectedIndex = -1
    var isCollapse = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFavListData()
        
        favTableView.estimatedRowHeight = 150
        favTableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    func getFavListData() {
        
        let url = getFavTrades
        
        let rateUrl = URL(string: url)!
        
        var request = URLRequest(url: rateUrl)
        request.httpMethod = "post"
        
        let favPayLoad = favPayload(user_id: UserDefaults.standard.integer(forKey:"userID" ))
        print("favPayLoad = \(favPayLoad)")
        let data = try! JSONEncoder().encode(favPayLoad)
        
        request.httpBody = data
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                    let rateResponse = try JSONDecoder().decode([favDetail].self, from: data)
                    print(" rateResponse =  \(rateResponse)")
                    
                    self.getFavList = rateResponse
                    
                    for i in rateResponse {
                        self.geFavchartData(data: i)
                    }
                    
                    DispatchQueue.main.async {self.favTableView.reloadData()
                        
                       
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
    
    func geFavchartData( data : favDetail ) {
        
        let url = TradeRate
        
        let tradeMarket = URL(string: url)!
        
        var request = URLRequest(url: tradeMarket)
        request.httpMethod = "POST"
        
        let favGraphPayLoad = favGraphPayLoad(market_id: data.market_id,
                                              trade_id: data.trade_id,
                                              subTrade_id: data.subTrade_id,
                                              trade_grade_id: data.tradeGrade_id)
        
        
        print("Boady \(favGraphPayLoad)" )
        debugPrint("Boady \(favGraphPayLoad)")
        
        
        let data = try! JSONEncoder().encode(favGraphPayLoad)
        
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
                    let GetGraphResponse = try JSONDecoder().decode([favRateGraph].self, from: data)
                    print(GetGraphResponse)
                    
                    
                    self.GetFaveGraphList[self.indexForFavGraphList] = GetGraphResponse[0]
                    

                    self.indexForFavGraphList=self.indexForFavGraphList+1
                    
                    
                    DispatchQueue.main.async { self.favTableView.reloadData()
                       
                        
                         
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
    
    
    
    
    
    
    func updateLineChart(forCellAt indexPath: IndexPath) {
        guard let cell = favTableView.cellForRow(at: indexPath) as? FavouriteCell else {
            return
        }
        
        var dataPoints: [ChartDataEntry] = []
        
        // Iterate over the arrays and create ChartDataEntry objects
        for i in 0..<min(GetFaveGraphList.count, GetFaveGraphList.count) {
            let dataPoint = ChartDataEntry( x: stringToDouble(date: GetFaveGraphList[i].rate_upd_date), y:  Double(GetFaveGraphList[i].rate) )
            
       
            
            dataPoints.append(dataPoint)
        }
        
        let dataSet = LineChartDataSet(entries: dataPoints, label: "Data")
        dataSet.colors = [UIColor.blue] // Customize line color
        
        // Remove dots
        dataSet.drawCirclesEnabled = false
        
        // Fill color above the line
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = UIColor.blue.withAlphaComponent(0.5) // Specify fill color with opacity
        
        let data = LineChartData(dataSet: dataSet)
        cell.lineChartView.data = data
        
        // Customize chart appearance
        cell.lineChartView.xAxis.enabled = false // Disable x-axis
        
        // Optionally, you can also hide the x-axis grid lines0
        cell.lineChartView.xAxis.drawGridLinesEnabled = false
        
        // Hide x-axis labels
        cell.lineChartView.xAxis.drawLabelsEnabled = false
        
        // Customize y-axis appearance
        cell.lineChartView.leftAxis.enabled = true // Disable left y-axis
        cell.lineChartView.rightAxis.enabled = false // Enable right y-axis
        
        
        cell.lineChartView.animate(xAxisDuration: 1.0)
    }
    
    
    func stringToDouble (date:String) -> Double {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let dateFormat = dateFormatter.date(from:date)!
        
        let timeInterval = dateFormat.timeIntervalSince1970
        
        // convert to Integer
        let myInt = Int(timeInterval)
        
        var di =  Double(myInt)
        
        return di
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        
        let url = removeFromFav
        let stringUrl = URL(string: url)!
        
        var request = URLRequest(url: stringUrl)
        request.httpMethod = "POST"
        
        let removePayload = removePayload(uid: UserDefaults.standard.integer(forKey: "userID"), market_id: market_id, trade_ID: trade_ID, sub_trade_id: sub_trade_id, trade_grade: trade_grade)
        print("removePayload = \(removePayload)")
        debugPrint("removePayload \(removePayload)")
        
        let data = try! JSONEncoder().encode(removePayload)
        
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
                    let removeDeatil = try JSONDecoder().decode(removeDeatil.self, from: data)
                    print(removeDeatil)
                    
                    if(removeDeatil.isSuccess){
                        print("data is remove ")
                        
                        self.getFavListData()
                    }
                    
                    
                    else{
                        print("Data is not remove")
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
}
   
   
    


extension favouriteVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex==indexPath.row && isCollapse == true{
            return 300
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       
            return getFavList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favCell = favTableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavouriteCell
        
         
            
               favCell.tradeName.text = String(getFavList[indexPath.row].marketname)
               favCell.subTradeName.text = getFavList[indexPath.row].trade_subtype
               favCell.rate.text = "\(GetFaveGraphList[indexPath.row].rate)" // Assuming rate is an integer
               
        for indexPath in self.favTableView.indexPathsForVisibleRows ?? [] {
            self.updateLineChart(forCellAt: indexPath)
        }
        
 
       

           
           
           return favCell
       }
    
//        favCell.marketName.text = String(getFavList[indexPath.row].trades_type)
//        favCell.subTradeName.text = getFavList[indexPath.row].trade_subtype
//        favCell.rate.text = String(GetFaveGraphList[indexPath.row].rate)
//
//        market_id = getFavList[indexPath.row].market_id
//        trade_ID = getFavList[indexPath.row].trade_id
//        sub_trade_id = getFavList[indexPath.row].subTrade_id
//        trade_grade = getFavList[indexPath.row].tradeGrade_id
//
//
//
//
//        return favCell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        

        
        selectedIndex = indexPath.row

        
        if selectedIndex==indexPath.row {
         
            if self.isCollapse==true
            {
 
                isCollapse=false
            }else{
                
                isCollapse=true }
        }
        
        
         favTableView.reloadRows(at: [indexPath], with: .automatic)
        
        print(indexPath.row)
    }
    
}


// fav Table View
struct favPayload : Encodable{
    
    let user_id : Int
}

struct favDetail : Codable {
    
    let fav_id : Int
    let market_id : Int
    let marketname : String
    let trade_id : Int
    let trades_type : String
    let subTrade_id : Int
    let trade_subtype : String
    let tradeGrade_id : Int
    let trade_grade : String
    let isDefault : String


    
}

// remove fav list


struct removePayload : Encodable {


    let uid : Int
    let market_id : Int
    let trade_ID : Int
    let sub_trade_id : Int
    let trade_grade : Int

}

struct removeDeatil : Codable {

    let isSuccess : Bool
    let message : String
    let id : Int
}


//graph

struct favGraphPayLoad: Encodable {

    let market_id:Int
    let trade_id:Int
    let subTrade_id:Int
    let trade_grade_id:Int
}

 

struct favRateGraph: Codable {

    let id:Int
    let market_ID:Int
    let trade_ID:Int
    let sub_trade_ID:Int
    let trade_Grade:Int
    let rate:Int
    let unit:String?
    let rate_Update_Status:String
    let rate_updated_by:Int
    let rate_upd_date:String
    let group_ID:Int
    let newRate:String?
   
}



//        if let  gofav = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteCellVC") as?  FavouriteCellVC {
//
//            gofav.market_id = getFavList[indexPath.row].market_id
//            gofav.trade_ID = getFavList[indexPath.row].trade_id
//            gofav.sub_trade_id = getFavList[indexPath.row].subTrade_id
//            gofav.trade_grade = getFavList[indexPath.row].tradeGrade_id
//
////            self.navigationController?.pushViewController(gofav, animated: true)
//        }
