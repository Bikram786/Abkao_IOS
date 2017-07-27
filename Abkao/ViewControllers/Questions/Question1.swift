//
//  Question1.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Question1: AbstractControl, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var setViewShadow: UIView!
    
    @IBOutlet weak var txtProduct: UITextField!

    @IBOutlet weak var pickerSuperView: UIView!
        
    var arrProducts : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var pickerProduct: UIPickerView!
    
    var objSpecialProduct : SpecialProductI?
    
    var scannedProductId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtProduct.text = ModelManager.sharedInstance.questionManager.dictQuestion["question1"] as? String
        
        setViewShadow.viewdraw(setViewShadow.bounds)
        
        
        txtProduct.addShadowToTextfield()
        
        
        pickerProduct.dataSource = self
        pickerProduct.delegate = self
        
        //temp
        //scannedProductId = "000002820000384"
        
        scannedProductId = ModelManager.sharedInstance.barcodeManager.barCodeValue
        
        ModelManager.sharedInstance.questionManager.getAllProductsNames(productScannedId: self.scannedProductId!) { (arrProductName, isSuccess, msg) in
            
            self.arrProducts.removeAllObjects()
            self.arrProducts.addObjects(from: arrProductName!)
            self.pickerProduct.reloadAllComponents()
            
            if(arrProductName?.count == 0)
            {
                let alert: UIAlertController = UIAlertController(title: "No product name found" as String, message: "I'm sorry but there is no commonly known name for this product." as String, preferredStyle: .alert)
                
                let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(nextAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        pickerSuperView.isHidden = true
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

        objSpecialProduct = specialProductObj
        
        
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
        
        
        if(arrProducts.count > 0)
        {
            objSpecialProduct = arrProducts.object(at: 0) as? SpecialProductI
        }
        
        ModelManager.sharedInstance.questionManager.dictQuestion["question1"] = objSpecialProduct?.name?.description as AnyObject
            
        
        txtProduct.text = objSpecialProduct?.name
        
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
    
    // MARK: - TextFiels Delegates
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
        self.pickerSuperView.isHidden = false
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
