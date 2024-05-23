//
//  ListingTradesVC.swift
//  APPlICATION
//
//  Created by Ashish on 04/04/24.
//

import UIKit

class ListingTradesVC: UIViewController {
    
    var getListingTradesList :Array<getListingTrades> = Array()
    
       
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var ListingTradesTable: UITableView!
    
    var searchingNames = [getListingTrades]()
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let url = ListingTrades
        
        let rateUrl = URL(string: url)!
        
        var request = URLRequest(url: rateUrl)
        request.httpMethod = "post"
        
        
        
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
                    let rateResponse = try JSONDecoder().decode([getListingTrades].self, from: data)
                    print(" rateResponse =  \(rateResponse)")
                    
                    self.getListingTradesList = rateResponse
                    
                    DispatchQueue.main.async {self.ListingTradesTable.reloadData() }
                    
                    
                    
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
        

extension ListingTradesVC : UITableViewDelegate,UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if searching {
            return searchingNames.count
        }else{
            return getListingTradesList.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let ListingTradesCell = ListingTradesTable.dequeueReusableCell(withIdentifier: "ListingTradesCell", for: indexPath) as! ListingTradesVCCell
    
    
        if searching{
            ListingTradesCell.TitleLbl.text = searchingNames[indexPath.row].item_Title
            
            
            let listing = searchingNames[indexPath.row]

               if let firstImageURL = listing.imageUrl.first,
                  let imageURL = URL(string: firstImageURL)
               {
                           // Fetch image data asynchronously
                           DispatchQueue.global().async {
                               if let imageData = try? Data(contentsOf: imageURL) {
                                   // Update UI on the main thread
                                   DispatchQueue.main.async {
                                         // Set the image to the cell's imageView
                                         ListingTradesCell.itemImage.image = UIImage(data: imageData)
                                     }
                                 }
                             }
                         }

                 

            ListingTradesCell.TitleLbl.text = searchingNames[indexPath.row].item_Title
            ListingTradesCell.tradeGradeName.text = searchingNames[indexPath.row].tradeGrade_name
            ListingTradesCell.Quantity.text = String(searchingNames[indexPath.row].item_Qty)
            ListingTradesCell.itemLocation.text = searchingNames[indexPath.row].item_location
          
        }else{
            
            ListingTradesCell.TitleLbl.text = getListingTradesList[indexPath.row].item_Title
            
            let listing = getListingTradesList[indexPath.row]

            if let firstImageURL = listing.imageUrl.first,
                  let imageURL = URL(string: firstImageURL)
               {
                           // Fetch image data asynchronously
                           DispatchQueue.global().async {
                               if let imageData = try? Data(contentsOf: imageURL) {
                                   // Update UI on the main thread
                                   DispatchQueue.main.async {
                                         // Set the image to the cell's imageView
                                         ListingTradesCell.itemImage.image = UIImage(data: imageData)
                                     }
                                 }
                             }
                         }

             

            ListingTradesCell.TitleLbl.text = getListingTradesList[indexPath.row].item_Title
            ListingTradesCell.tradeGradeName.text = getListingTradesList[indexPath.row].tradeGrade_name
            ListingTradesCell.Quantity.text = String(getListingTradesList[indexPath.row].item_Qty)
            ListingTradesCell.itemLocation.text = getListingTradesList[indexPath.row].item_location
        }
        return ListingTradesCell
        
    }

        
        
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let ListingTradesCell = ListingTradesTable.dequeueReusableCell(withIdentifier: "ListingTradesCell", for: indexPath) as! ListingTradesVCCell
//
//
//
//
//        let listing = getListingTradesList[indexPath.row]
//
//        if let firstImageURL = listing.imageUrl.first,
//           let imageURL = URL(string: firstImageURL)
//        {
//                    // Fetch image data asynchronously
//                    DispatchQueue.global().async {
//                        if let imageData = try? Data(contentsOf: imageURL) {
//                            // Update UI on the main thread
//                            DispatchQueue.main.async {
//                                // Set the image to the cell's imageView
//                                ListingTradesCell.itemImage.image = UIImage(data: imageData)
//                            }
//                        }
//                    }
//                }
//
//
//
//        let itemTitle = getListingTradesList[indexPath.row].item_Title
//        let quantity = getListingTradesList[indexPath.row].item_Qty
//        let itemLlocation = getListingTradesList[indexPath.row].item_location
//        let tradeGradeName = getListingTradesList[indexPath.row].tradeGrade_name
//        let itemLocation = getListingTradesList[indexPath.row].item_location
//        let image = getListingTradesList[indexPath.row].imageUrl[0]
//
//        ListingTradesCell.TitleLbl.text = ("\(itemTitle)")
//        ListingTradesCell.tradeGradeName.text = ("\(tradeGradeName)")
//        ListingTradesCell.Quantity.text = "\(quantity)"
//        ListingTradesCell.itemLocation.text = (" \(itemLocation)")
//
//
//        return ListingTradesCell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let  goDetail = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailVC") as?  ItemDetailVC {

            
            if searching{
                
                goDetail.prodcutDetails = searchingNames[indexPath.row]
                goDetail.from = "listingtradelist"
            }else{

            goDetail.prodcutDetails = getListingTradesList[indexPath.row]
            goDetail.from = "listingtradelist"
            }

            
            self.navigationController?.pushViewController(goDetail, animated: true)
                    }
        
        print("pos = \(indexPath.row)")

    }
    
}

extension ListingTradesVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText = \(searchText)")
        searchingNames = getListingTradesList.filter({$0.item_Title .lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        ListingTradesTable.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
    }
}


struct getListingTrades : Codable {
    
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
    let listing_Created_by  : Int
    let listing_Created_by_name  : String
    let imageUrl: [String]
    let unit : String
    let item_Qty : Int
    let minimum_Qty : Int
    let available_Qty : Int
    
}

