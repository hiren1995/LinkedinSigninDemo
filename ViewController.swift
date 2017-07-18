//
//  ViewController.swift
//  LinkedinSigninDemo
//
//  Created by APPLE MAC MINI on 18/07/17.
//  Copyright © 2017 APPLE MAC MINI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelname: UILabel!
    
    
    @IBAction func btnSignin(_ sender: Any) {
        
        
        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: { (success) in
            
            let session = LISDKSessionManager.sharedInstance().session
            
            let url = "https://api.linkedin.com/v1/people/~"
            
            if(LISDKSessionManager.hasValidSession()){
                
                LISDKAPIHelper.sharedInstance().getRequest(url, success: { (response) in
                    
                    
                    let dict=self.stringToDictionary(text: (response?.data)!)
                    print("your last name is \(dict?["lastName"])")
                    
                    let name = "your last name is \(dict?["lastName"])"
                    
                    self.labelname.text = name
                    
                }, error: { (error) in
                    print(error)
                })
            }
            
        }) { (error) in
            
            print("Error is : \(String(describing: error))")
            
        }
        
    }
    
    func stringToDictionary(text:String)->[String:Any]?{
        
        if let data = text.data(using: .utf8){
            do{
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                
            }catch{
                print(error.localizedDescription)
            }
        }
        return nil
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

