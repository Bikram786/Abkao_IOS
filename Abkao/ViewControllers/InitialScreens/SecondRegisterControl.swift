//
//  SecondRegisterControl.swift
//  Abkao
//
//  Created by Inder on 03/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import SVProgressHUD

class SecondRegisterControl: AbstractControl, UIPickerViewDelegate, UIPickerViewDataSource {

    // Get Previous Values
    
     var firstName:String?
     var lastName:String?
     var userName:String?
     var password:String?
     var companyName:String?
     var email:String?
    
     @IBOutlet weak var setViewShadow: UIView!
     @IBOutlet weak var txt_AccountName: UITextField!
     @IBOutlet weak var txt_AccountNo: UITextField!
     @IBOutlet weak var txt_City: UITextField!
     @IBOutlet weak var txt_State: UITextField!
     @IBOutlet weak var txt_Telephone: UITextField!
     @IBOutlet weak var txt_ZipCode: UITextField!
     @IBOutlet weak var txt_Address: UITextField!
     @IBOutlet weak var btn_Country: UIButton!
     @IBOutlet weak var countryView: UIView!
     @IBOutlet weak var selectCityAndStatePickerView: UIPickerView!
     @IBOutlet weak var countryPickerView: UIView!
    
    var arrCountries : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryView.setViewBoarder()
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_AccountName.addShadowToTextfield()
        txt_AccountNo.addShadowToTextfield()
        txt_City.addShadowToTextfield()
        txt_State.addShadowToTextfield()
        txt_Telephone.addShadowToTextfield()
        txt_ZipCode.addShadowToTextfield()
        txt_Address.addShadowToTextfield()
        countryPickerView.isHidden = true
        selectCityAndStatePickerView.isHidden = true
        btn_Country.titleLabel!.font =  UIFont(name: "Cormorant-Regular", size: 17)
        //get Countries list
        ModelManager.sharedInstance.authManager.getCountriesList { (arrCountryI, isSuucess) in
            self.arrCountries = arrCountryI!
            self.selectCityAndStatePickerView.reloadAllComponents()
        }
    }

    override var showRight: Bool{
        return false
    }
    
    func checkValues(){
        
        guard let accountNo = txt_AccountNo.text, accountNo != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill account number")
            return
        }
        guard let userCity = txt_City.text, userCity != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill city name")
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
        guard let address = txt_Address.text, address != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill address")
            return
        }
        guard let zipCode = txt_ZipCode.text, zipCode != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill zip code")
            return
        }
        guard let state = txt_State.text, state != "" else {
            
            SVProgressHUD.showError(withStatus: "Please fill state name")
            return
        }
            
            if btn_Country.titleLabel?.text == "Country"{
                SVProgressHUD.showError(withStatus: "Please fill country name")
            }else{
                
                var  dictData : [String : Any] =  [String : Any]()
                dictData["first_name"] = firstName
                dictData["last_name"] = lastName
                dictData["username"] = userName
                dictData["email"] = email
                dictData["password"] = password
                dictData["account_name"] = accountName
                dictData["account_number"] = accountNo
                dictData["address"] = address
                dictData["city"] = userCity
                dictData["state"] = state
                dictData["zip"] = zipCode
                dictData["country"] = btn_Country.titleLabel?.text
                dictData["telephone"] = userTelephone
                
                print(dictData)
                
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

    
    @IBAction func btn_CountryAction(_ sender: UIButton) {
        
        countryPickerView.isHidden=false
        selectCityAndStatePickerView.isHidden = false
    }
    
    @IBAction func btn_RsgisterAction(_ sender: UIButton) {
        
        checkValues()
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
