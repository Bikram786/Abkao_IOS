//
//  RegisterControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterControl: AbstractControl {
    
    // IBOutlets
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_AccountNo: UITextField!
    @IBOutlet weak var txt_City: UITextField!
    @IBOutlet weak var txt_Country: UITextField!
    
    @IBOutlet weak var txt_UserName: UITextField!
    
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
    
    var arrCountries : NSMutableArray = NSMutableArray()
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
        
        //get Countries list
        ModelManager.sharedInstance.authManager.getCountriesList { (arrCountryI, isSuucess) in
            
            self.arrCountries = arrCountryI!
        }
    }
    
    func setStartingFields() {
        
        // upperView.upperdraw(upperView.bounds)
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_FirstName.addShadowToTextfield()
        txt_LastName.addShadowToTextfield()
        txt_AccountNo.addShadowToTextfield()
        txt_City.addShadowToTextfield()
        txt_Country.addShadowToTextfield()
        txt_UserName.addShadowToTextfield()
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
        
        guard let firstName = txt_FirstName.text, firstName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill first name")
            return
        }
        guard let accountNo = txt_AccountNo.text, accountNo != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill account number")
            return
        }
        guard let userCity = txt_City.text, userCity != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill city name")
            return
        }
        guard let userCountry = txt_Country.text, userCountry != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill country name")
            return
        }
        guard let userName = txt_UserName.text, userName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill user ID")
            return
        }
        guard let lastName = txt_LastName.text, lastName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill user lastname")
            return
        }
        guard let accountName = txt_AccountName.text, accountName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill account name")
            return
        }
        guard let userTelephone = txt_Telephone.text, userTelephone != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill telephone")
            return
        }
        guard let userPassword = txt_Password.text, userPassword != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill user password")
            return
        }
        guard let companyName = txt_Company.text, companyName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill company name")
            return
        }
        
        guard let address = txt_Address.text, address != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill address")
            return
        }
        guard let zipCode = txt_ZipCode.text, zipCode != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill zip code")
            return
        }
        guard let email = txt_Email.text, email != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill Email")
            return
        }
        guard let confirmPassword = txt_ConfirmPassword.text, confirmPassword != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill confirm password")
            return
        }
        
        guard let state = txt_State.text, state != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill state name")
            return
        }
        
        if userPassword != confirmPassword {
            
            SVProgressHUD.showError(withStatus: "Password or confirm password not matched")
        }
        
        let checkEmail = isValidEmail(testStr: email)
        
        if checkEmail != true{
            
            SVProgressHUD.showError(withStatus: "Please fill valid Email-ID")
            
        }else{
            
            var  dictData : [String : Any] =  [String : Any]()
            dictData["first_name"] = firstName
            dictData["last_name"] = lastName
            dictData["username"] = userName
            dictData["email"] = email
            dictData["password"] = userPassword
            dictData["account_name"] = accountName
            dictData["account_number"] = accountNo
            dictData["address"] = address
            dictData["city"] = userCity
            dictData["state"] = state
            dictData["zip"] = zipCode
            dictData["country"] = userCountry
            dictData["telephone"] = userTelephone
            
            print(dictData)
            
            SVProgressHUD.show(withStatus: "Loding.....")
            
            ModelManager.sharedInstance.authManager.userSignUp(userInfo: dictData) { (userObj, isSuccess, strMessage) in
                SVProgressHUD.dismiss()
                if(isSuccess){
                    SVProgressHUD.showError(withStatus: strMessage)
                   _ = self.navigationController?.popViewController(animated: true)
                }else{
                    
                    SVProgressHUD.showError(withStatus: strMessage)
                }

                
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
