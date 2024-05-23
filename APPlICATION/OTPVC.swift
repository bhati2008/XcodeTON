//
//  OTPVC.swift
//  APPlICATION
//
//  Created by Ashish on 16/03/24.
//

import UIKit
import Lottie
class OTPVC: UIViewController {
    
    @IBOutlet weak var OtpNavigation: LottieAnimationView!
    
    @IBOutlet var otpTxt: UITextField!
    
    @IBOutlet var noLbl: UILabel!
    
     @IBOutlet var submitBtn: UIButton!
    
    
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         submitBtn.layer.cornerRadius = 30
        
        OtpNavigation.contentMode = .scaleAspectFit
        OtpNavigation.loopMode = .loop
        OtpNavigation.play()
        
        
        self.navigationController?.isNavigationBarHidden = false
      
        
        
        noLbl.text = "Phone: \(phone)"
    }
    
   @IBAction func submitBtn(_ sender: Any) {

                    let url = ConstBaseUrl + ValidateOTP


                    guard let otpUrl = URL(string: url) else {
                        debugPrint("Invalid URL")
                        return
                    }

                    var request = URLRequest(url: otpUrl)
                    request.httpMethod = "post"

                    let payLoadOtp = PayLoadOtp(mobile: phone,
                                                otp: otpTxt.text ?? "",
                                                device_Id: "2")

                debugPrint(payLoadOtp )



                    let data = try! JSONEncoder().encode(payLoadOtp)

                    request.httpBody = data
                    request.setValue(
                        "application/json",
                        forHTTPHeaderField: "Content-Type"
                    )

                    let task = URLSession.shared.dataTask(with: request) { data, responce, error in

                        let statusCode = (responce as! HTTPURLResponse).statusCode

                        if statusCode == 200 {
                            debugPrint("succesFull")

                            guard let data = data else {
                                debugPrint("invalid Data")
                                return
                            }

                            do{


                                var _responseData =  try  JSONDecoder().decode(responseData.self, from: data)



                                if (_responseData.isSuccess){

                                    if (_responseData.id != 0 ){
                                        debugPrint("you ragister all radey")
                                        debugPrint(_responseData.id)

                                        UserDefaults.standard.set(_responseData.id, forKey: "userID")
                                        UserDefaults.standard.set(true, forKey: "isLogin")
                                        

                                        DispatchQueue.main.async {


       if let  goBar  = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as?  ViewController {
           
           
                    self.navigationController?.pushViewController(goBar, animated: true)
           print("10")
                }



                     }

                 }else{

                     if let  goReg  = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as?  ViewController {
                         self.navigationController?.pushViewController(goReg, animated: true)
                       
                     }
                     debugPrint("Ragister First")


                 }
                 debugPrint("validotp" )

                     }else{print("Invalid Otp")}

         }catch{
             print("Data Persing problem ")
             debugPrint("Data Persing problem")
                            }

                        }else{
                            debugPrint("fails")
                        }
                    }
                    task.resume()

                 }
        
        
        
        
        }
        
        struct PayLoadOtp : Encodable{
        
        let mobile : String
        let otp : String
        let device_Id : String
        }
        
        struct  responseData : Codable
        {
            var isSuccess: Bool
            var message: String
            var id: Int
        }
            
    
    
    

