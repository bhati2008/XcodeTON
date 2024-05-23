//
//  PhoneViewController.swift
//  APPlICATION
//
//  Created by Ashish on 15/03/24.
//

import UIKit
import Lottie

class PhoneViewController: UIViewController {
    
    
    
    @IBOutlet weak var NumberAnimation: LottieAnimationView!
    
    @IBOutlet var GetOTP: UIButton!
    @IBOutlet var EnterPhoneNo: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetOTP.layer.cornerRadius = 30
        
    self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)

        NumberAnimation.contentMode = .scaleAspectFit
        NumberAnimation.loopMode = .loop
        NumberAnimation.play()
        
    }
    
    
   @IBAction func GetOTP(_ sender: Any) {
        
         GetOTP.layer.cornerRadius = 30
        
        
                    let url =    ConstBaseUrl+Generateloginotp
        
                    guard let apiUrl = URL(string: url) else {
                        debugPrint( "InVlid URL")
                         return
                    }
        
                    var request = URLRequest(url: apiUrl)
                    request.httpMethod = "POST"
        
                    let payLoad = PayLoad(
                        mobile: EnterPhoneNo.text  ?? ""
                    )
        
                    let data = try! JSONEncoder().encode(payLoad)
        
                    request.httpBody = data
                    request.setValue(
                        "application/json",
                        forHTTPHeaderField: "Content-Type"
                    )
        
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        let statusCode = (response as! HTTPURLResponse).statusCode
        
                        if statusCode == 200 {
                             debugPrint( "SUCCESS")
 
                            debugPrint(response ?? "no response")
        
                            guard let data = data else {
                                print("request failed \(String(describing: error))")
                                        return
                                }
        
                            do {
                                let person = try JSONDecoder().decode(Person.self, from: data)
                                print(" person = \(person)")
                                if(person.isSuccess){
        
        
                                    DispatchQueue.main.async {
        
        if let  getOTPVC  = self.storyboard?.instantiateViewController(withIdentifier: "OTPVC") as?  OTPVC {
            
               getOTPVC.phone = self.EnterPhoneNo.text!

            
            self.navigationController?.pushViewController(getOTPVC, animated: true)
        }
        
                                    }
        
        
        
                                }else{
                                    print("invalid phone no")
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
        
        struct PayLoad: Encodable {
        
            let mobile: String
        
        }
        
        struct Person: Codable {
            var isSuccess: Bool
            var message: String
            var id: Int
        
    }


