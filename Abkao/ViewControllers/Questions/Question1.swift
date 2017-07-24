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
    
    var selectedProductName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtProduct.text = ModelManager.sharedInstance.questionManager.dictQuestion["question1"] as? String
        
        setViewShadow.viewdraw(setViewShadow.bounds)

        
        txtProduct.addShadowToTextfield()

        
        pickerProduct.dataSource = self
        pickerProduct.delegate = self
        
        
        
        
//        ModelManager.sharedInstance.questionManager.getDepartments(locationId: (locationID?.description)!) { (arrDepartMentsObj, isSuccess, msg) in
//            
//            self.arrDepartments?.addObjects(from: arrDepartMentsObj!)
//            self.pickerDepartments.reloadAllComponents()
//            
//        }

    }
    
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

        selectedProductName = specialProductObj.name
        
        
    }
    
    // MARK: - Custom Functions
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question2") as! Question2
        self.navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    
    @IBAction func clkDone(_ sender: Any) {
        
        ModelManager.sharedInstance.questionManager.setValue(selectedProductName, forKey: "question1")
        
        txtProduct.text = selectedProductName
        
        pickerSuperView.isHidden = true
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
