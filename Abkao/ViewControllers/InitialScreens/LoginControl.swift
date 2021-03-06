//
//  LoginControl.swift
//  Abkao
//
//  Created by CSPC162 on 09/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginControl: AbstractControl {
    
    // IBOutlets
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_UserName: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    
    @IBOutlet weak var setUpper: UIView!
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
    }
    
    func setStartingFields() {
        
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_UserName.addShadowToTextfield()
        txt_Password.addShadowToTextfield()
        
    }
    
    // MARK: - Super Class Method
    
    override var showLeft: Bool{
        return false
    }
    
    override var showRight: Bool{
        return false
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func btn_LoginAction(_ sender: UIButton) {
        
        guard let userName = txt_UserName.text, userName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter user name")
            return
        }
        guard let userPassword = txt_Password.text, userPassword != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter user passowrd")
            
            return
        }
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["username"] = userName
        dictData["password"] = userPassword
//        dictData["username"] = "npurwar"
//        dictData["password"] = "123456"
        
        SVProgressHUD.show(withStatus: "Loading.....")
        
        ModelManager.sharedInstance.authManager.userLogin(userInfo: dictData) { (userObj, isSuccess, strMessage) in
            
            SVProgressHUD.dismiss()
            
            if(isSuccess)
            {
                self.performSegue(withIdentifier: "goto_homeview", sender: nil)
            }
            else
            {
                SVProgressHUD.showError(withStatus: strMessage)
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
