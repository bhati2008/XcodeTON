//
//  ItemDetailVC.swift
//  APPlICATION
//
//  Created by Ashish on 08/04/24.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    
    
    
    //Image
    @IBOutlet weak var MainImage: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    //Lbl
    @IBOutlet weak var ItemIDLbl: UILabel!
    @IBOutlet weak var QuantityLbl: UILabel!
    @IBOutlet weak var TradeLbl: UILabel!
    @IBOutlet weak var TradeTypeLbl: UILabel!
    @IBOutlet weak var MinimumQuantityLbl: UILabel!
    @IBOutlet weak var itemDescriptionLbl: UILabel!
    @IBOutlet weak var ItemLocationLbl: UILabel!
    
    @IBOutlet weak var itemName: UILabel!
    
    var from = ""
    
    var prodcutDetails : Any?
    
    var Image1 = ""
    var Image2 = ""
    var Image3 = ""
    var Image4 = ""
    var ItemID  = 0
    var Quantity = ""
    var Trade  = ""
    var TradeType  = ""
    var MinimumQuantity  = 0
    var itemDescription = ""
    var ItemLocation  = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configer ()
        
        MainImage.layer.cornerRadius = 10
        image1.layer.cornerRadius = 10
        image2.layer.cornerRadius = 10
        image3.layer.cornerRadius = 10
        image4.layer.cornerRadius = 10
        
        
        
        
        
        if (from == "listingtradelist") { let ok = prodcutDetails as! getListingTrades
            
            
            
            let image = ok.imageUrl
            
            let urlMain = URL(string: image[0])!
            // Fetch Image Data
            
            URLSession.shared.dataTask(with: urlMain) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.MainImage.image = UIImage(data: imageData)
                }
            }.resume()
            
            
            let url0 = URL(string: image[0])!
            // Fetch Image Data
            
            URLSession.shared.dataTask(with: url0) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image1.image = UIImage(data: imageData)
                }
            }.resume()
            
            let url1 = URL(string: image[1])!
            URLSession.shared.dataTask(with: url1) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image2.image = UIImage(data: imageData)
                }
            }.resume()
            let url2 = URL(string: image[2])!
            URLSession.shared.dataTask(with: url2) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image3.image = UIImage(data: imageData)
                }
            }.resume()
            
            let url3 = URL(string: image[3])!
            URLSession.shared.dataTask(with: url3) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image4.image = UIImage(data: imageData)
                }
            }.resume()
            
            
            ItemIDLbl.text = String(ok.listing_id)
            QuantityLbl.text = String(ok.item_Qty)
            TradeLbl.text = ok.trade_name
            TradeTypeLbl.text = ok.tradeGrade_name
            MinimumQuantityLbl.text = String(ok.minimum_Qty)
            itemDescriptionLbl.text = ok.item_description
            ItemLocationLbl.text = ok.item_location
            itemName.text = ok.item_Title
            
            print("image1 = \(String(describing: image1))")
            print("Image1 = \(String(describing: Image1))")
            print("okk = \(String(describing: ok.imageUrl[1]))")
            
            
        }else{
            
            let ok = prodcutDetails as! bidListResponce
            
            
            let image = ok.imageUrls
            
            let urlMain = URL(string: image[0])!
            // Fetch Image Data
            
            URLSession.shared.dataTask(with: urlMain) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.MainImage.image = UIImage(data: imageData)
                }
            }.resume()
            
            
            let url0 = URL(string: image[0])!
            // Fetch Image Data
            
            URLSession.shared.dataTask(with: url0) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image1.image = UIImage(data: imageData)
                }
            }.resume()
            
            let url1 = URL(string: image[1])!
            URLSession.shared.dataTask(with: url1) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image2.image = UIImage(data: imageData)
                }
            }.resume()
            let url2 = URL(string: image[2])!
            URLSession.shared.dataTask(with: url2) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image3.image = UIImage(data: imageData)
                }
            }.resume()
            
            let url3 = URL(string: image[3])!
            URLSession.shared.dataTask(with: url3) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image4.image = UIImage(data: imageData)
                }
            }.resume()
            
            
            ItemIDLbl.text = String(ok.listing_id)
            QuantityLbl.text = String(ok.item_Qty)
            TradeLbl.text = ok.trade_name
            TradeTypeLbl.text = ok.tradeGrade_name
            MinimumQuantityLbl.text = String(ok.minimum_Qty)
            itemDescriptionLbl.text = ok.item_description
            ItemLocationLbl.text = ok.item_location
            itemName.text = ok.item_Title
            
            print("image1 = \(String(describing: image1))")
            print("Image1 = \(String(describing: Image1))")
            print("okk = \(String(describing: ok.imageUrls[1]))")
            
            
        }
        
    }
    
    func configer (){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(SideMenuBtn))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc func SideMenuBtn() {
        performSegue(withIdentifier: "ShowSideMenu", sender: self)
       }
    
  
    
    
    
    
    
    @IBAction func bidPlaceBtn(_ sender: Any) {
        if let  sendBidData = self.storyboard?.instantiateViewController(withIdentifier: "saveBidDetailsVC") as?  saveBidDetailsVC {
            
            
            if (from == "listingtradelist") {
                
                let ok = prodcutDetails as! getListingTrades
                sendBidData.listedId = ok.listing_id
                sendBidData.id = ok .trade_Type_id
                
               
                
                
            }else{
                
                
                let ok = prodcutDetails as! bidListResponce
                sendBidData.listedId = ok.listing_id
                sendBidData.id = ok.trade_Type_id
            }
            navigationController?.pushViewController(sendBidData, animated: true)
           
        }
    }
}


