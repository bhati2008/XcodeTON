//
//  myBidListing.swift
//  APPlICATION
//
//  Created by Ashish on 20/05/24.
//

import UIKit

class myBidListing: UIViewController {
    
 var bidList :Array<bidListResponce> = Array()

    
    @IBOutlet weak var bidListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bidListData()
    }
    
    func bidListData(){
        
        let url = bidListdetail
        
        let bidUrl = URL(string: url)!
        
        var request = URLRequest(url: bidUrl)
        request.httpMethod = "post"
        
        let bidListPayLoad = bidListPayLoad(user_id: UserDefaults.standard.integer(forKey: "userID"))
        
        let data = try! JSONEncoder().encode(bidListPayLoad)
        
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
                    let rateResponse = try JSONDecoder().decode([bidListResponce].self, from: data)
                    print(" rateResponse =  \(rateResponse)")
                    
                    self.bidList = rateResponse
                    
                    DispatchQueue.main.async {self.bidListTableView.reloadData() }
                    
                    
                    
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

extension myBidListing : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bidList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bidListCell = bidListTableView.dequeueReusableCell(withIdentifier: "bidListCell", for: indexPath) as! myBidListCellVC
        bidListCell.item_Title.text = bidList[indexPath.row].item_Title
        bidListCell.bid_amount.text = String(bidList[indexPath.row].bid_amount)
        bidListCell.bidCount.text = String(bidList[indexPath.row].bidCount)
        
        
        let listing = bidList[indexPath.row]
        
        if let firstImageURL = listing.imageUrls.first,
           let imageURL = URL(string: firstImageURL)
        {
            // Fetch image data asynchronously
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        // Set the image to the cell's imageView
                        bidListCell.bidListImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // Existing date format
        if let date = dateFormatter.date(from: bidList[indexPath.row].bidTime)
            
            
        {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Desired date format
            let formattedDate = dateFormatter.string(from: date)
            bidListCell.bidTime.text = formattedDate
            
        } else {
            bidListCell.bidTime.text = bidList[indexPath.row].bidTime
        }
        
        let dateFormattera = DateFormatter()
        dateFormattera.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // Existing date format
        if let date = dateFormattera.date(from: bidList[indexPath.row].listing_Created_on)
            
            
        {
            dateFormattera.dateFormat = "yyyy-MM-dd HH:mm" // Desired date format
            let formattedDate = dateFormattera.string(from: date)
            bidListCell.listing_Created_on.text = formattedDate
            
        } else {
            bidListCell.listing_Created_on.text = bidList[indexPath.row].listing_Created_on
        }
        
        
        return bidListCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let  goDetail = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC") as?  ItemDetailVC {
            goDetail.prodcutDetails = bidList[indexPath.row]
            goDetail.from = "myBidListing"
            
            self.navigationController?.pushViewController(goDetail, animated: true)
            
        }
    }
    
    
}
    
struct bidListPayLoad : Codable {
    
    let user_id : Int
}

struct bidListResponce : Codable {
    
    let listing_id : Int
    let trade_id : Int
    let trade_name : String?
    let trade_Type_id : Int
    let sub_Trade_name : String?
    let grade_type_id : Int
    let tradeGrade_name : String?
    let item_Title : String
    let item_condition : String
    let item_description : String
    let item_location : String
    let item_getBid_Offer : String
    let bidCount : Int
    let listing_Created_on  : String
    let bidTime  : String
    let listing_Created_by  : Int
    let listing_Created_by_name:String
    let bid_amount:Int
    let imageUrls: [String]
    let user_message : String
    let item_Qty : Int
    let minimum_Qty : Int
    let bid_Qty : Int
    
}

