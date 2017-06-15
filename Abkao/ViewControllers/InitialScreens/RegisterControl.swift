//
//  RegisterControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class RegisterControl: AbstractControl {

    // IBOutlets
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_AccountNo: UITextField!
    @IBOutlet weak var txt_City: UITextField!
    @IBOutlet weak var txt_Country: UITextField!
    @IBOutlet weak var txt_UserID: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_AccountName: UITextField!
    @IBOutlet weak var txt_State: UITextField!
    @IBOutlet weak var txt_Telephone: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_Company: UITextField!
    @IBOutlet weak var txt_Address: UITextField!
    @IBOutlet weak var txt_ZipCode: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
    }
    
    func setStartingFields() {
        
        // upperView.upperdraw(upperView.bounds)
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_FirstName.addShadowToTextfield()
        txt_LastName.addShadowToTextfield()
        txt_AccountNo.addShadowToTextfield()
        txt_City.addShadowToTextfield()
        txt_Country.addShadowToTextfield()
        txt_UserID.addShadowToTextfield()
        txt_AccountName.addShadowToTextfield()
        txt_State.addShadowToTextfield()
        txt_Telephone.addShadowToTextfield()
        txt_Password.addShadowToTextfield()
        txt_Company.addShadowToTextfield()
        txt_Address.addShadowToTextfield()
        txt_ZipCode.addShadowToTextfield()
        txt_Email.addShadowToTextfield()
        txt_ConfirmPassword.addShadowToTextfield()
    }

    // MARK: - Validation Method
    
    func checkValues(){
        
        if (txt_FirstName.text?.isEmpty)! || (txt_LastName.text?.isEmpty)! || (txt_AccountNo.text?.isEmpty)! || (txt_City.text?.isEmpty)! || (txt_Country.text?.isEmpty)! || (txt_UserID.text?.isEmpty)! || (txt_AccountName.text?.isEmpty)! || (txt_State.text?.isEmpty)! || (txt_Telephone.text?.isEmpty)! || (txt_Password.text?.isEmpty)! || (txt_Company.text?.isEmpty)! || (txt_Address.text?.isEmpty)! || (txt_ZipCode.text?.isEmpty)! || (txt_Email.text?.isEmpty)! || (txt_ConfirmPassword.text?.isEmpty)! {
            
        }else {
            
            let checkEmail = isValidEmail(testStr: txt_Email.text!)
            
            print(checkEmail)
            
            if checkEmail == true {
                
            }else{
                
            }
            
        }
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - Super Class Method
    
    override var showRight: Bool{
        return false
    }
    
    // MARK: - IBAction Methods
    
    
    @IBAction func btn_RegisterAction(_ sender: UIButton) {
        
        checkValues()
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
