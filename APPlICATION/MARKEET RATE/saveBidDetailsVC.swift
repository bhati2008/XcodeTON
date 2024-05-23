//
//  saveBidDetailsVC.swift
//  APPlICATION
//
//  Created by Ashish on 11/04/24.
//

import UIKit

class saveBidDetailsVC: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var ItemAmount: UITextField!
    @IBOutlet weak var ItemQuantity: UITextField!
    @IBOutlet weak var ItemConditions: UILabel!
    @IBOutlet weak var ListingID: UILabel!
    
    @IBOutlet weak var Amount: UILabel!
    
    
    @IBOutlet weak var ItemSubmitBtn: UIButton!
    @IBOutlet weak var CancelItem: UIButton!
    
    var listedId = 0
    var id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Add target for editingChanged event to both text fields
        ItemAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        ItemQuantity.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Call updateResultLabel when the view loads to update the label with initial values
        updateResultLabel()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateResultLabel()
    }
    
    // Method to update the result label based on the values in the text fields
    func updateResultLabel() {
        // Convert text field values to integers, or use 0 if conversion fails
        let number1 = Int(ItemAmount.text ?? "") ?? 0
        let number2 = Int(ItemQuantity.text ?? "") ?? 0
        
        // Add the numbers
        let result = number1 * number2
        
        // Display the result in the label as an integer
        Amount.text = "\(result)"
        
    }

    
    @IBAction func SubmitBid(_ sender: Any) {
        
       // let bid = bidDetails as! getListingTrades
    
        
         let amount = ItemAmount.text
         let quantity = ItemQuantity.text
         let conditions = ItemConditions.text
         
     
        
        
        let url = SaveBidDetails
        
        let tradeMarket = URL(string: url)!
        
        var request = URLRequest(url: tradeMarket)
        request.httpMethod = "POST"
        
        

//        let BidDetailPayLoad = BidDetailPayLoad(listing_id:0 , listing_Bid_Amount: (ItemAmount.text! as NSString) .integerValue, bid_done_by: 0, user_message: ItemConditions.text!, bid_Qty: (ItemQuantity.text! as NSString).integerValue )

        
           let BidDetailPayLoad = BidDetailPayLoad(listing_id:listedId ,
                                                   listing_Bid_Amount: (ItemAmount.text! as NSString) .integerValue,
                                                   bid_done_by: UserDefaults.standard.integer(forKey: "userID"),
                                                   user_message: ItemConditions.text!,
                                                   bid_Qty: (ItemQuantity.text! as NSString).integerValue )

        debugPrint("BidDetailPayLoad =  \(BidDetailPayLoad)")


        
        let data = try! JSONEncoder().encode(BidDetailPayLoad)

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
                    let bidDetail = try JSONDecoder().decode(bidDetail.self, from: data)
                    
                    print ("GetbidDetail = \(bidDetail)")
                    
                    if(bidDetail.isSuccess){


                        DispatchQueue.main.async {

                            DispatchQueue.main.async {
                                // Dismiss the current view controller
                                self.dismiss(animated: true) {
                                    // After dismissal, navigate back to ViewController
                                    if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") {
                                        if let navigationController = self.navigationController {
                                            navigationController.pushViewController(viewController, animated: true)
                                        } else {
                                            self.present(viewController, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                            }



                    }
                    
                    else{
                        print("invalid Data")
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
struct BidDetailPayLoad: Encodable {
    
    let listing_id:Int
    let listing_Bid_Amount:Int
    let bid_done_by:Int
    let user_message:String
    let bid_Qty:Int
    
}




struct bidDetail : Codable {
    
    let isSuccess:Bool
    let message:String
    let id:Int
    
}



