//
//  FirstRegisterControl.swift
//  Abkao
//
//  Created by Inder on 03/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import SVProgressHUD

class FirstRegisterControl: AbstractControl {

    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_FirstName: UITextField?
    @IBOutlet weak var txt_UserName: UITextField?
    @IBOutlet weak var txt_LastName: UITextField?
    @IBOutlet weak var txt_Password: UITextField?
    @IBOutlet weak var txt_ConfirmPassword: UITextField?
    @IBOutlet weak var txt_Company: UITextField?
    @IBOutlet weak var txt_Email: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_FirstName?.addShadowToTextfield()
        txt_LastName?.addShadowToTextfield()
        txt_UserName?.addShadowToTextfield()
        txt_Password?.addShadowToTextfield()
        txt_ConfirmPassword?.addShadowToTextfield()
        txt_Company?.addShadowToTextfield()
        txt_Email?.addShadowToTextfield()
        txt_FirstName?.setRightImage()
        txt_LastName?.setRightImage()
        txt_Email?.setRightImage()
        txt_Password?.setRightImage()
    }
    
    override var showRight: Bool{
        return false
    }
    
    func checkValid(){
        
        guard let firstName = txt_FirstName?.text, firstName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill first name")
            return
        }
        guard let lastName = txt_LastName?.text, lastName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill user lastname")
            return
        }
        guard let userPassword = txt_Password?.text, userPassword != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill user password")
            return
        }
        guard let confirmPassword = txt_ConfirmPassword?.text, confirmPassword != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill confirm password")
            return
        }
        
        if userPassword != confirmPassword {
            
            SVProgressHUD.showError(withStatus: "Password or confirm password not matched")
        }
        else{
            
            guard let email = txt_Email?.text, email != "" else {
                
                SVProgressHUD.showError(withStatus: "Please fill Email-ID")
                return
            }
            
            if (!(txt_Email?.text?.isEmpty)!) {
                
                let checkEmail = isValidEmail(testStr: (txt_Email?.text)!)
                
                if checkEmail != true{
                    
                    SVProgressHUD.showError(withStatus: "Please fill valid Email-ID")
                    
                }else{
                    
                    let myVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondRegisterControl") as! SecondRegisterControl
                    myVC.firstName = txt_FirstName?.text
                    myVC.lastName = txt_LastName?.text
                    myVC.userName = txt_UserName?.text
                    myVC.password = txt_Password?.text
                    myVC.companyName = txt_Company?.text
                    myVC.email = email
                    self.navigationController?.pushViewController(myVC, animated: true)
                    
                }
            }

//            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondRegisterControl") as! SecondRegisterControl
//            myVC.firstName = txt_FirstName?.text
//            myVC.lastName = txt_LastName?.text
//            myVC.userName = txt_UserName?.text
//            myVC.password = txt_Password?.text
//            myVC.companyName = txt_Company?.text
//            myVC.email = txt_Email?.text
//            self.navigationController?.pushViewController(myVC, animated: true)
            
        }


    }
    
    func isValidEmail(testStr:String) -> Bool {
       
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func btn_NextViewAction(_ sender: UIButton) {
        
        checkValid()
     
    }

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
