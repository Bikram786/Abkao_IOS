//
//  Question6.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import SVProgressHUD


class Question6: AbstractControl,UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txtDiscount: UITextField!
    
    @IBOutlet weak var pickerSuperView: UIView!
    @IBOutlet weak var viewPicker: UIPickerView!
    

    
    var objDiscount : DiscountI?
    var arrDiscounts : NSMutableArray = NSMutableArray()

    var isChecked : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewShadow.viewdraw(setViewShadow.bounds)
        txtDiscount.addShadowToTextfield()
        
        viewPicker.dataSource = self
        viewPicker.delegate = self
        
        txtDiscount.isUserInteractionEnabled = true
        
        objDiscount = ModelManager.sharedInstance.questionManager.dictQuestion["question6"] as? DiscountI
        
        txtDiscount.text = objDiscount?.recordName
        
        if(txtDiscount.text == "No Thanks")
        {
            objDiscount = nil
            txtDiscount.isUserInteractionEnabled = false
            isChecked = true
            txtDiscount.text = ""
            btnCheckBox.setImage(UIImage(named: "tick.png"), for: UIControlState.normal)
        }
        
        
        SVProgressHUD.show(withStatus: "Loading.......")

        ModelManager.sharedInstance.questionManager.getAllDiscounts(handler: { (arrDiscounts, isSuccess, msg) in
            
            SVProgressHUD.dismiss()
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
    
    override var navTitle: String {
        
        return "OnlyLeftBack"
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
        
        return discountObj.recordName?.description
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
        
        if((objDiscount == nil) && (arrDiscounts.count > 0))
        {
            objDiscount = arrDiscounts.object(at: 0) as? DiscountI
        }
        
        ModelManager.sharedInstance.questionManager.dictQuestion["question6"] = objDiscount as AnyObject
        
        txtDiscount.text = objDiscount?.recordName?.description
        
        pickerSuperView.isHidden = true
    }
    
    @IBAction func clkbtnCheck(_ sender: Any) {
        
        if(isChecked)
        {
            btnCheckBox.setImage(UIImage(named: "untick.png"), for: UIControlState.normal)
            txtDiscount.isUserInteractionEnabled = true

            isChecked = false
        }
        else
        {
            btnCheckBox.setImage(UIImage(named: "tick.png"), for: UIControlState.normal)
            
            objDiscount = nil
            isChecked = true
            txtDiscount.isUserInteractionEnabled = false

            txtDiscount.text = ""
            
            ModelManager.sharedInstance.questionManager.dictQuestion["question6"] = "No Thanks" as AnyObject
            
        }
    }
    
    func validateData()->Bool {
        
        if(!isChecked)
        {
            if(txtDiscount.text == "")
            {
                ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter checkout discount")
                
                
                return false
            }
            
            return true
        }
        return true
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
