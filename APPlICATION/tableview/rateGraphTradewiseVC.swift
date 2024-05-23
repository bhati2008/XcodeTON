//
//  rateGraphTradewiseVC.swift
//  APPlICATION
//
//  Created by Ashish on 02/04/24.
//

import UIKit
import Charts

class rateGraphTradewiseVC: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
  
    
    var GetMarketRateGraphList : Array<GetRateGraph> = Array()
    // var GetMarketRateGraphList :[GetRateGraph] = []
    
  
    
    
    
    
    var market_id = 0
    var trade_id  = 0
    var subTrade_id  = 0
    var trade_grade_id = 0
    
    @IBOutlet weak var MarketRateGraphTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         
        configer ()
        
        print(" Ratelist = \(GetMarketRateGraphList)")
        
        let url = TradeRate
        
        let tradeMarket = URL(string: url)!
        
        var request = URLRequest(url: tradeMarket)
        request.httpMethod = "POST"
        
        let rateGraphPayLoad = rateGraphPayLoad(market_id: market_id, trade_id: trade_id, subTrade_id: subTrade_id, trade_grade_id: trade_grade_id)
        
        
        print("Boady \(rateGraphPayLoad)" )
        debugPrint("Boady \(rateGraphPayLoad)")
        
        
        let data = try! JSONEncoder().encode(rateGraphPayLoad)
        
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
                    let GetGraphResponse = try JSONDecoder().decode([GetRateGraph].self, from: data)
                    print(GetGraphResponse)
                    
                    
                    self.GetMarketRateGraphList = GetGraphResponse
                    
                   
                    
                    DispatchQueue.main.async { self.MarketRateGraphTable.reloadData() }
                    
                
                    self.updateLineChart()
                    
                

                    
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
    
    
    
    func updateLineChart() {
        var dataPoints: [ChartDataEntry] = []
        
        // Iterate over the arrays and create ChartDataEntry objects
        for i in 0..<min(GetMarketRateGraphList.count, GetMarketRateGraphList.count) {
            let dataPoint = ChartDataEntry( x: stringToDouble(date: GetMarketRateGraphList[i].rate_upd_date), y:  Double(GetMarketRateGraphList[i].rate) )
            
            //let dataPoint = ChartDataEntry(x: Double(GetMarketRateGraphList[i].rate), y: stringToDouble(date: GetMarketRateGraphList[i].rate_upd_date) )

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
        lineChartView.data = data
        
        // Customize chart appearance
        lineChartView.xAxis.enabled = false // Disable x-axis
    
        // Optionally, you can also hide the x-axis grid lines0
        lineChartView.xAxis.drawGridLinesEnabled = false
        
        // Hide x-axis labels
        lineChartView.xAxis.drawLabelsEnabled = false
                
        // Customize y-axis appearance
        lineChartView.leftAxis.enabled = true // Disable left y-axis
        lineChartView.rightAxis.enabled = false // Enable right y-axis
        
        
        lineChartView.animate(xAxisDuration: 1.0)
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
    
    @IBAction func addFavBtn(_ sender: Any) {

        let url = addToFav
        let stringUrl = URL(string: url)!

        var request = URLRequest(url: stringUrl)
        request.httpMethod = "POST"

        let saveFavPayLoad = saveFavPayLoad(uid: UserDefaults.standard.integer(forKey: "userID"),
                                    market_id: market_id,
                                    trade_ID: trade_id,
                                    sub_trade_id: subTrade_id,
                                    trade_grade: trade_grade_id)

        print("favPayLoad = \(saveFavPayLoad)")

        let data = try! JSONEncoder().encode(saveFavPayLoad)

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
                    let saveFavDetail = try JSONDecoder().decode(saveFavDetail.self, from: data)
                    print(saveFavDetail)

                    if(saveFavDetail.isSuccess){
                        print("data is save ")
                    }


                    else{
                        print("Data is not save")
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
    
    





extension rateGraphTradewiseVC: UITableViewDelegate,UITableViewDataSource{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetMarketRateGraphList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let GraphRateCell = MarketRateGraphTable.dequeueReusableCell(withIdentifier: "GraphRateCell", for: indexPath) as! GraphtDataCell
        let MarketRate =  GetMarketRateGraphList[indexPath.row].rate
        let MarketRateUdateBy = GetMarketRateGraphList[indexPath.row].rate_updated_by
        let date = GetMarketRateGraphList[indexPath.row].rate_upd_date


        GraphRateCell.textLabel?.text = GetMarketRateGraphList[indexPath.row].rate_upd_date
        GraphRateCell.RateLbl.text = "\(MarketRate)"
        GraphRateCell.RateDiffrenceLbl.text = "Rs +\(MarketRateUdateBy)"




        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // Existing date format
        if let date = dateFormatter.date(from: GetMarketRateGraphList[indexPath.row].rate_upd_date)
        {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Desired date format
            let formattedDate = dateFormatter.string(from: date)
            GraphRateCell.textLabel?.text = formattedDate

        } else {
            GraphRateCell.textLabel?.text = GetMarketRateGraphList[indexPath.row].rate_upd_date
        }

       return GraphRateCell

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let GraphRateCell = MarketRateGraphTable.dequeueReusableCell(withIdentifier: "GraphRateCell", for: indexPath)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // Existing date format
            if let date = dateFormatter.date(from: GetMarketRateGraphList[indexPath.row].rate_upd_date) {
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Desired date format
                let formattedDate = dateFormatter.string(from: date)
                GraphRateCell.textLabel?.text = formattedDate
            } else {
                GraphRateCell.textLabel?.text = GetMarketRateGraphList[indexPath.row].rate_upd_date
            }

            return GraphRateCell
        }
        

    }
}


struct rateGraphPayLoad: Encodable {

    let market_id:Int
    let trade_id:Int
    let subTrade_id:Int
    let trade_grade_id:Int
}

 

struct GetRateGraph: Codable {

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


// favourate Button API Struct

struct saveFavPayLoad : Encodable{
    
    let uid : Int
    let market_id : Int
    let trade_ID : Int
    let sub_trade_id : Int
    let trade_grade : Int
}
struct saveFavDetail : Codable {
    
    let isSuccess : Bool
    let message : String
    let id : Int
}
