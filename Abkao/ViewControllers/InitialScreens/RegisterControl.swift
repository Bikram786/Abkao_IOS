//
//  RegisterControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterControl: AbstractControl, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // IBOutlets
    
    var data = ["One", "Two", "Three"]
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_AccountNo: UITextField!
    @IBOutlet weak var txt_City: UITextField!
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
    @IBOutlet weak var selectCityAndStatePickerView: UIPickerView!
    @IBOutlet weak var countryPickerView: UIView!
    
    @IBOutlet weak var btn_Country: UIButton!
    
    @IBOutlet weak var countryView: UIView!
    
    var arrCountries : NSMutableArray = NSMutableArray()
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
        
        //get Countries list
        ModelManager.sharedInstance.authManager.getCountriesList { (arrCountryI, isSuucess) in
        self.arrCountries = arrCountryI!
        self.selectCityAndStatePickerView.reloadAllComponents()
        }
    }
    
    func setStartingFields() {
        
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
        btn_Country.titleLabel!.font =  UIFont(name: "Cormorant-Regular", size: 17)
        countryPickerView.isHidden=true
        selectCityAndStatePickerView.isHidden = true
        setViewShadow.viewdraw(setViewShadow.bounds)
        countryView.setViewBoarder()
        txt_FirstName.addShadowToTextfield()
        txt_LastName.addShadowToTextfield()
        txt_AccountNo.addShadowToTextfield()
        txt_City.addShadowToTextfield()
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
    
    //MARK: - UIPickerView Delegate & Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ModelManager.sharedInstance.authManager.arrCountry!.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let countryObj = ModelManager.sharedInstance.authManager.arrCountry?.object(at: row) as! CountryI
        return countryObj.countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let countryObj = ModelManager.sharedInstance.authManager.arrCountry?.object(at: row) as! CountryI
        btn_Country.setTitle(countryObj.countryName, for: .normal)
        btn_Country.setTitleColor(.black, for: .normal)
        countryPickerView.isHidden=true
        selectCityAndStatePickerView.isHidden = true
    }
   
    func getStateList(getContury: CountryI){
        
        ModelManager.sharedInstance.authManager.getStatesList(countryObj: getContury) { (arrCountryI, isSuucess) in
            
            self.arrCountries = arrCountryI!
            self.selectCityAndStatePickerView.reloadAllComponents()
            
        }
        
    }
    
    // MARK: - Validation Method
    
    func checkValues(){
        
        guard let firstName = txt_FirstName.text, firstName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter first name")
            return
        }
        guard let accountNo = txt_AccountNo.text, accountNo != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter account number")
            return
        }
        guard let userCity = txt_City.text, userCity != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter city name")
            return
        }
        guard let userName = txt_UserName.text, userName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter user ID")
            return
        }
        guard let lastName = txt_LastName.text, lastName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter user lastname")
            return
        }
        guard let accountName = txt_AccountName.text, accountName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter account name")
            return
        }
        guard let userTelephone = txt_Telephone.text, userTelephone != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter telephone")
            return
        }
        guard let userPassword = txt_Password.text, userPassword != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter user password")
            return
        }
        guard let companyName = txt_Company.text, companyName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter company name")
            return
        }
        
        guard let address = txt_Address.text, address != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter address")
            return
        }
        guard let zipCode = txt_ZipCode.text, zipCode != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter zip code")
            return
        }
        guard let email = txt_Email.text, email != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter Email")
            return
        }
        guard let confirmPassword = txt_ConfirmPassword.text, confirmPassword != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter confirm password")
            return
        }
        
        guard let state = txt_State.text, state != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter state name")
            return
        }
        
        if userPassword != confirmPassword {
            
            SVProgressHUD.showError(withStatus: "Password or confirm password not matched")
        }
        
        let checkEmail = isValidEmail(testStr: email)
        
        if checkEmail != true{
            
            SVProgressHUD.showError(withStatus: "Email address not valid")
            
        }else{
            
            if btn_Country.titleLabel?.text == "Country"{
                SVProgressHUD.showError(withStatus: "Please enter country name")
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
                dictData["country"] = btn_Country.titleLabel?.text
                dictData["telephone"] = userTelephone
                                
                SVProgressHUD.show(withStatus: "Loading.....")
                
                ModelManager.sharedInstance.authManager.userSignUp(userInfo: dictData) { (userObj, isSuccess, strMessage) in
                    SVProgressHUD.dismiss()
                    if(isSuccess){
                        self.performSegue(withIdentifier: "goto_homeview", sender: nil)
                    }else{
                        
                        SVProgressHUD.showError(withStatus: strMessage)
                    }
                    
                    
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
    
    
    @IBAction func btn_CountryAction(_ sender: UIButton) {
        
        countryPickerView.isHidden=false
        selectCityAndStatePickerView.isHidden = false
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
