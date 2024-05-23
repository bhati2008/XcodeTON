//
//  ContactUsVC.swift
//  APPlICATION
//
//  Created by Ashish on 10/05/24.
//

import UIKit
import DropDown
import Lottie

class ContactUsVC: UIViewController {
    
    var id = 0
    
    var queryDataList: [queryResponce] = []
    var contactList: [contactUsResponce] = []
    
    @IBOutlet weak var contactNo: UILabel!
    @IBOutlet weak var emailId: UILabel!
    @IBOutlet weak var supportTime: UILabel!
    
    
    @IBOutlet weak var animationViewContactUs: LottieAnimationView!
    @IBOutlet weak var animationViewMassage: LottieAnimationView!
    
    @IBOutlet weak var QueryView: UIView!
    @IBOutlet weak var QueryLbl: UILabel!
    
    let selectQueryDropDown = DropDown()
    var selectQueryArray : [String] = []
    
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var feedbackText: UITextField!
    
    
    @IBAction func selectTrdetBtn(_ sender: Any) {
        selectQueryDropDown.show()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationViewContactUs.contentMode = .scaleAspectFit
        animationViewContactUs.loopMode = .loop
        animationViewContactUs.play()
        
        animationViewMassage.contentMode = .scaleAspectFit
        animationViewMassage.loopMode = .loop
        animationViewMassage.play()
        
        // selectTradeDropDown
        selectQueryDropDown.anchorView = QueryView
        selectQueryDropDown.dataSource = selectQueryArray
        
        selectQueryDropDown.bottomOffset = CGPoint(x: 0, y: (selectQueryDropDown.anchorView?.plainView.bounds.height)!)
        selectQueryDropDown.topOffset = CGPoint(x: 0, y: -(selectQueryDropDown.anchorView?.plainView.bounds.height)!)
        selectQueryDropDown.direction = .bottom
        
        selectQueryDropDown.selectionAction = { (index:Int,item:String) in
            self.QueryLbl.text = self.selectQueryArray[index]
            self.QueryLbl.textColor = .black
        }
        

        queryData()
        contactUsData()
    }
    
    
    
    func queryData() {
        
        let url = QueryList
        
        
        let QueryUrl = URL(string: url)!
        
        var request = URLRequest(url: QueryUrl)
        request.httpMethod = "get"
        
        
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("a = \(statusCode)")
            
            if statusCode == 200 {
                print( "SUCCESS")
                
                
                
                debugPrint(response ?? "no response")
                
                guard let data = data else  {
                    print("request failed \(String(describing: error))")
                    return
                }
                
                
                do {
                    let queryResponse = try JSONDecoder().decode([queryResponce].self, from: data)
                    print("queryResponse = \(queryResponse)")
                    
                    
                    
                    //  self.RateDataList = rateResponse.value
                    
                    
                    
                    let selectQuery = queryResponse.map { $0.query }
                    print("Trade Names: \(selectQuery)")
                    
                    
                    DispatchQueue.main.async {
                        
                        self.selectQueryArray = selectQuery
                        self.selectQueryDropDown.dataSource = self.selectQueryArray
                    }
                    
                    
                    
                }
                catch {
                    print("Error: \(error)")
                }
                
                
                
            } else {
                print("FAILURE")
                
                
            }
        }
        task.resume()
        print(UserDefaults.standard.integer(forKey: "userID"))
    }
    
    func contactUsData() {

        
        let url = "http://arsimapi.arsim.co.in/api/CreateUser/GetContact_Us"
        
        let rateUrl = URL(string: url)!
        
        var request = URLRequest(url: rateUrl)
        request.httpMethod = "GET"
        
        
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            debugPrint(statusCode)
            debugPrint("DATA Boady = \(String(describing: data))")
            
            
            if statusCode == 200 {
                print( "SUCCESS2")
                
                
                
                debugPrint(response ?? "no response")
                
                guard let data = data else  {
                    print("request failed \(String(describing: error))")
                    return
                }
                
                
                do {
                    
                    let rateResponse = try JSONDecoder().decode(contactUsResponce.self, from: data)
                    print(" rateResponse =  \(rateResponse)")
                    
                    DispatchQueue.main.async {
                        self.contactNo.text = rateResponse.contact_no
                        self.emailId.text = rateResponse.email_Id
                        self.supportTime.text = rateResponse.support_Time
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

    
    @IBAction func submitBtn(_ sender: Any) {
        
        let query = QueryLbl.text
        let message = messageText.text
        let feedback = feedbackText.text
        
        
        let url = feedbackSave
        
        let feedbacksave = URL(string: url)!
        
        var request = URLRequest(url: feedbacksave)
        request.httpMethod = "POST"
        
        let feedBackPayLoad = feedbackPayLoad(feedback_by:UserDefaults.standard.integer(forKey:"userID"), f_message: feedbackText.text!, ismessage: messageText.text!, queryType: (QueryLbl.text! as NSString).integerValue)
        
        debugPrint("feedBackPayLoad =  \(feedBackPayLoad)")
        
        let data = try! JSONEncoder().encode(feedBackPayLoad)
        request.httpBody = data
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                    let feeadbackDetail = try JSONDecoder().decode(feeadbackDetail.self, from: data)
                    
                    print ("feeadbackDetail = \(feeadbackDetail)")
                    
                    if(feeadbackDetail.isSuccess){
                        print("data is save ")
                        
  
                    }else{
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
       
print("quert = \(query)")
        
    }

}
//quert struct
struct queryResponce : Codable {
    
    let id: Int
    let query: String
 
    }

//sumbitbtbn struct

struct feedbackPayLoad: Encodable {
    
    let feedback_by:Int
    let f_message:String
    let ismessage:String
    let queryType:Int
    
}
struct feeadbackDetail : Codable {
    
    let isSuccess:Bool
    let message:String
    let id:Int
    
}

struct contactUsResponce:Codable {
    
    let contact_no:String
    let email_Id:String
    let support_Time:String
    
}
