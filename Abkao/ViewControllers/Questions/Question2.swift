//
//  Question2.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Question2: AbstractControl,UITextFieldDelegate {

    var arrPrices : NSMutableArray = NSMutableArray()

    @IBOutlet weak var lblGrossMargin: UILabel!
    @IBOutlet weak var lblSugestedRetail: UILabel!
    @IBOutlet weak var lblLastPurchasePrice: UILabel!
    @IBOutlet weak var lblLastPurchaseDate: UILabel!
    @IBOutlet weak var lblLastPurchaseVendor: UILabel!

    
    
    @IBOutlet weak var txtProductPrice: UITextField!
    @IBOutlet weak var setViewShadow: UIView!


    @IBOutlet weak var pickerSuperView: UIView!
    
    
    @IBOutlet weak var viewPicker: UIPickerView!
    
    
    var selectedPrice : String?
    
    var scannedProductId : String?
    var locationId : String?
    
    var objSellingPrice : SellingPriceI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pickerSuperView.isHidden = true
        
        txtProductPrice.text = ModelManager.sharedInstance.questionManager.dictQuestion["question2"] as? String

        txtProductPrice.delegate = self
        
        setViewShadow.viewdraw(setViewShadow.bounds)

        txtProductPrice.addShadowToTextfield()
        
        
        //temp code
        //scannedProductId = "000002820000384"
        //locationID = 93027

        locationId =  ModelManager.sharedInstance.profileManager.userObj!.accountNo
        
        
        scannedProductId = ModelManager.sharedInstance.barcodeManager.barCodeValue
        
        ModelManager.sharedInstance.questionManager.getSellingPrice(productScannedId: (scannedProductId?.description)!, locationID: (locationId?.description)!) { (objSP, isSuccess, msg) in
        
            self.objSellingPrice = objSP
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide , object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }
    
    override var navTitle: String {
        
        return "OnlyLeftBack"
    }
    
    func calculateGrossMargin(spObj : SellingPriceI)  {
        
        
        let strPrice = txtProductPrice.text
        let floatPrice = (strPrice! as NSString).floatValue
        
        let grossMargin = (floatPrice)/(spObj.strLastPurcahsePrice! - 1)
        
        let twoDecimalPlaces = String(format: "%.2f", grossMargin)

        lblGrossMargin.text = "\(twoDecimalPlaces.description) %"
        lblSugestedRetail.text = "\(String(describing: spObj.strSuggestedRetail!.description))$"
        lblLastPurchasePrice.text = "\(String(describing: spObj.strLastPurcahsePrice!.description))$"
        lblLastPurchaseDate.text = spObj.strLastPurchaseDate
        lblLastPurchaseVendor.text = spObj.strLastPurchaseVendor
        
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        pickerSuperView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIPickerView Delegate & Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPrices.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //let priceObj = arrPrices.object(at: row) as! DepartmentI
        
        //return priceObj.departmentNo?.description
        
        return "price"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
//        let departmentObj = arrDepartments?.object(at: row) as! DepartmentI
//        
//        selectedDepartmentNo =  departmentObj.departmentNo?.description
        
    }
     
     @IBAction func clkDone(_ sender: Any) {
     
     ModelManager.sharedInstance.questionManager.setValue(selectedPrice, forKey: "question2")
     
     pickerSuperView.isHidden = true
     }
     
     
    */
    // MARK: - Custom Functions
    
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        if(validateData())
        {            
            ModelManager.sharedInstance.questionManager.dictQuestion["question2"] = txtProductPrice.text as AnyObject
            
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question3") as! Question3
            self.navigationController?.pushViewController(myVC, animated: true)
        }
    }
    
    func validateData()->Bool {
        
        if(txtProductPrice.text == "")
        {
            ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter selling price")
            
            return false
        }
        
        return true
        
    }
    

    
    // MARK: - TextFiels Delegates
    
    func keyboardWillHide(_ notification: NSNotification) {
        print("Keyboard will hide!")
        
        self.calculateGrossMargin(spObj: objSellingPrice!)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //textField.resignFirstResponder()
        //self.pickerSuperView.isHidden = false
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    {
        if string == "" {return true}
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "1234567890.")) == nil ? false : true
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
