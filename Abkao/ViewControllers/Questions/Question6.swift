//
//  Question6.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Question6: AbstractControl,UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txtDiscount: UITextField!
    
    @IBOutlet weak var pickerSuperView: UIView!
    @IBOutlet weak var viewPicker: UIPickerView!
    
    
    var objDiscount : DiscountI?
    var arrDiscounts : NSMutableArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewShadow.viewdraw(setViewShadow.bounds)
        txtDiscount.addShadowToTextfield()
        
        ModelManager.sharedInstance.questionManager.getAllDiscounts(handler: { (arrDiscounts, isSuccess, msg) in
            
            self.arrDiscounts.addObjects(from: arrDiscounts!)
            self.viewPicker.reloadAllComponents()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        pickerSuperView.isHidden = true
    }
    
    //MARK: - UIPickerView Delegate & Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrDiscounts.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let discountObj = arrDiscounts.object(at: row) as! DiscountI
        
        return discountObj.price?.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        objDiscount = arrDiscounts.object(at: row) as? DiscountI
        
        //        selectedDepartmentNo =  departmentObj.departmentNo?.description
        
    }
    
    // MARK: - Custom Functions
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "summaryvc") as! SummaryVC
        self.navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    
    
    @IBAction func clkDone(_ sender: Any) {
        
        ModelManager.sharedInstance.questionManager.dictQuestion["question6"] = objDiscount?.price?.description as AnyObject
        
        txtDiscount.text = objDiscount?.price?.description
        
        pickerSuperView.isHidden = true
    }
    
    // MARK: - TextFiels Delegates
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
        self.pickerSuperView.isHidden = false
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
