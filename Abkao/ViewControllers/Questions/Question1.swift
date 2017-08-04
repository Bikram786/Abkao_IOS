//
//  Question1.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import SVProgressHUD


class Question1: AbstractControl, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var setViewShadow: UIView!
    
    @IBOutlet weak var txtProduct: UITextField!

    @IBOutlet weak var pickerSuperView: UIView!
        
    var arrProducts : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var pickerProduct: UIPickerView!
    
    var objSpecialProduct : SpecialProductI?
    
    var scannedProductId : String?
    
    var isDataReceived : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        txtProduct.text = ModelManager.sharedInstance.questionManager.dictQuestion["question1"] as? String
        
        //objSpecialProduct = ModelManager.sharedInstance.questionManager.dictQuestion["question1"] as? SpecialProductI
        
        //txtProduct.text = objSpecialProduct?.name
        
        setViewShadow.viewdraw(setViewShadow.bounds)
        
        
        txtProduct.addShadowToTextfield()
        
        
        pickerProduct.dataSource = self
        pickerProduct.delegate = self
        
        
        scannedProductId = ModelManager.sharedInstance.barcodeManager.barCodeValue
        
        //temp
        
        //scannedProductId = "000002820000384"
        
        
        SVProgressHUD.show(withStatus: "Loading.......")

        ModelManager.sharedInstance.questionManager.getAllProductsNames(productScannedId: self.scannedProductId!) { (arrProductName, isSuccess, msg) in
            
            self.arrProducts.removeAllObjects()
            self.arrProducts.addObjects(from: arrProductName!)
            self.pickerProduct.reloadAllComponents()
            
            SVProgressHUD.dismiss()
            
            if(arrProductName?.count == 0)
            {
                self.isDataReceived = false
                
                let alert: UIAlertController = UIAlertController(title: "No product name found" as String, message: "I'm sorry but there is no commonly known name for this product." as String, preferredStyle: .alert)
                
                let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                    
                    
                }
                
                alert.addAction(nextAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                self.isDataReceived = true
            }
        }
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var navTitle: String {
        
        return "OnlyLeftBack"
    }
    
    //MARK: - UIPickerView Delegate & Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrProducts.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let specialProductObj = arrProducts.object(at: row) as! SpecialProductI
        
        return specialProductObj.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let specialProductObj = arrProducts.object(at: row) as! SpecialProductI

        txtProduct.text = specialProductObj.name
        
        
    }
    
    // MARK: - Custom Functions
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        if(validateData())
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question2") as! Question2
            self.navigationController?.pushViewController(myVC, animated: true)
        }
    }
    
    
    @IBAction func clkDone(_ sender: Any) {
                
        if((objSpecialProduct == nil) && (arrProducts.count > 0))
        {
            objSpecialProduct = arrProducts.object(at: 0) as? SpecialProductI
        }
        
        txtProduct.text = objSpecialProduct?.name
        
        ModelManager.sharedInstance.questionManager.dictQuestion["question1"] = txtProduct.text as AnyObject
            
        
        
        pickerSuperView.isHidden = true
    }
    
    func validateData()->Bool {
        
        if(txtProduct.text == "")
        {
            ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter product name")
            
            return false
        }
        return true

    }
    
    // MARK: - Default Functions
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        pickerSuperView.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide , object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK: - TextFiels Delegates
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if(isDataReceived)
        {
            textField.resignFirstResponder()
            
            self.pickerSuperView.isHidden = false
        }
        else
        {
            self.pickerSuperView.isHidden = true
        }

    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        
        print("Keyboard will hide!")
        
        ModelManager.sharedInstance.questionManager.dictQuestion["question1"] = txtProduct.text as AnyObject
        
    }
    
//    override var navTitle: String{
//        return "Logout"
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
