//
//  LoginControl.swift
//  Abkao
//
//  Created by CSPC162 on 09/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class LoginControl: AbstractControl {

    // IBOutlets
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_UserID: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    
    @IBOutlet weak var setUpper: UIView!
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()       
    }
        
    func setStartingFields() {
        
      
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_UserID.addShadowToTextfield()
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
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["username"] = "npurwar"
        dictData["password"] = "123456"
                
        ModelManager.sharedInstance.authManager.userLogin(userInfo: dictData) { (userObj, isSuccess, strMessage) in
            
            if(isSuccess)
            {
                 print(userObj.userID!)
                
                self.performSegue(withIdentifier: "goto_homeview", sender: nil)
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
