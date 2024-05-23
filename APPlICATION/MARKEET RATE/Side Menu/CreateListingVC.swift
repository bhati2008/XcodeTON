//
//  CreateListingVC.swift
//  APPlICATION
//
//  Created by Ashish on 01/05/24.
//

import UIKit
import DropDown

class CreateListingVC: UIViewController {
   // var RateDataList : Array<CreateListResponse> = Array()
    var trade_id = 0
    
    @IBOutlet weak var selectTradeView: UIView!
    
    
    
    @IBOutlet weak var selectTradeLbl: UILabel!
    
    
    
    let selectTradeDropDown = DropDown()
    
    
    
    var selectTadeArray : [String] = []
    
    
    
    
    @IBAction func selectTrdetBtn(_ sender: Any) {
        selectTradeDropDown.show()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      // selectTradeDropDown
        selectTradeDropDown.anchorView = selectTradeView
        selectTradeDropDown.dataSource = selectTadeArray
        
        selectTradeDropDown.bottomOffset = CGPoint(x: 0, y: (selectTradeDropDown.anchorView?.plainView.bounds.height)!)
        selectTradeDropDown.topOffset = CGPoint(x: 0, y: -(selectTradeDropDown.anchorView?.plainView.bounds.height)!)
        selectTradeDropDown.direction = .bottom
        
        selectTradeDropDown.selectionAction = { (index:Int,item:String) in
            self.selectTradeLbl.text = self.selectTadeArray[index]
            self.selectTradeLbl.textColor = .black
        
            
            
                  }

        
        createList()
    }
    
    
    
    func createList() {
        
        
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
                        let rateResponse = try JSONDecoder().decode(CreateListResponseArray.self, from: data)
                        print("rateResponse = \(rateResponse)")
                       
                        
                        
                      //  self.RateDataList = rateResponse.value
                        
                     
                        
                        let selectTradeNames = rateResponse.value.map { $0.tradeName }
                                                print("Trade Names: \(selectTradeNames)")
                                                
                        let trade_id = rateResponse.value.map { $0.trade_id }
                                                print("Trade Names: \(trade_id)")

                        DispatchQueue.main.async {
                                                   self.selectTadeArray = selectTradeNames
                                                   self.selectTradeDropDown.dataSource = self.selectTadeArray
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
   
// Select Trade API
struct CreateListResponse : Codable {
    
   let trade_id: Int
   let tradeName: String
   let tradeType: String
   let status: String
    
    }
struct CreateListResponseArray : Codable {
    
   let value: Array<CreateListResponse>
    
    
    }
