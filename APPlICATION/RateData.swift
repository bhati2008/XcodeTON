//
//  RateData.swift
//  APPlICATION
//
//  Created by Ashish on 27/03/24.
//

import UIKit

class RateData: UITableViewController {
    


    var RateDataList : Array<rateResponse> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        
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
                    let rateResponse = try JSONDecoder().decode(rateResponseArray.self, from: data)
                    print("rateResponse")
                   debugPrint(rateResponse)
                    
                    self.RateDataList = rateResponse.value
                    
                   DispatchQueue.main.async { self.tableView.reloadData() }
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
    
    
   
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RateDataList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RateCell
//        cell.rateList.text = RateDataList[indexPath.row].tradeName
//        cell.backgroundColor = UIColor.white
//        cell.layer.borderColor = UIColor.black.cgColor
//        //cell.layer.borderWidth = 5
//        cell.layer.cornerRadius = 30
    

        
        return cell
    }
    

           

}


struct rateResponse : Codable {
    
   let trade_id: Int
   let tradeName: String
   let tradeType: String
   let status: String
    
    }
struct rateResponseArray : Codable {
    
   let value: Array<rateResponse>
    
    
    }
