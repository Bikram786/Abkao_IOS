//
//  ForgotPasswordControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForgotPasswordControl: AbstractControl {
    
    // IBOutlet
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_Email: UITextField!
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
        setStartingFields()
        
    }
    
    func setStartingFields() {
        
        // upperView.upperdraw(upperView.bounds)
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_Email.addShadowToTextfield()
        
    }
    
    // MARK: - Super Class Method
    
    override var showRight: Bool{
        return false
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    // MARK: - IBAction Methods
    
    @IBAction func btn_SubmitAction(_ sender: UIButton) {
        
        guard let userEmail = txt_Email.text, userEmail != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill Email-ID")
            
            return
        }
        
        let checkEmail = isValidEmail(testStr: txt_Email.text!)
        
        if checkEmail != true{
            
            SVProgressHUD.showError(withStatus: "Please fill valid Email-ID")
            
        }else{
            
            var  dictData : [String : Any] =  [String : Any]()
            dictData["email"] = userEmail
                       
            SVProgressHUD.show(withStatus: "Loading.....")
            
            ModelManager.sharedInstance.authManager.forgotPassword(userInfo: dictData) { (isSuccess, strMessage) in
                
                SVProgressHUD.dismiss()
                
                if(isSuccess)
                {
                    SVProgressHUD.showError(withStatus: strMessage)
                    _ = self.navigationController?.popViewController(animated: true)
                    
                }else{
                    
                    SVProgressHUD.showError(withStatus: strMessage)
                }
                
            }
            
        }
        
        
        
    }
    
    // MARK: - Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
