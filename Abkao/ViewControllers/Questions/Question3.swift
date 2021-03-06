//
//  Question3.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import SVProgressHUD


class Question3: AbstractControl, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var departmentObj : DepartmentI?
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var setViewShadow: UIView!

    
    @IBOutlet weak var pickerSuperView: UIView!
    
    var locationID : String?
    
    var arrDepartments : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var viewPicker: UIPickerView!
    
    @IBOutlet weak var pickerDepartments: UIPickerView!
    
    var selectedDepartmentNo : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setViewShadow.viewdraw(setViewShadow.bounds)
        txtDepartment.addShadowToTextfield()

        viewPicker.dataSource = self
        viewPicker.delegate = self
        
//        txtDepartment.text = ModelManager.sharedInstance.questionManager.dictQuestion["question3"] as? String
        
        
        departmentObj = ModelManager.sharedInstance.questionManager.dictQuestion["question3"] as? DepartmentI
        
        txtDepartment.text = departmentObj?.departmentName?.description
                
        
        locationID =  ModelManager.sharedInstance.profileManager.userObj!.accountNo

        //temp code
        //locationID = "93027"

        SVProgressHUD.show(withStatus: "Loading.......")

        ModelManager.sharedInstance.questionManager.getDepartments(locationId: (locationID?.description)!) { (arrDepartMentsObj, isSuccess, msg) in
            
            SVProgressHUD.dismiss()
            
            self.arrDepartments.addObjects(from: arrDepartMentsObj!)
            self.pickerDepartments.reloadAllComponents()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        pickerSuperView.isHidden = true
    }
    
    override var navTitle: String {
        
        return "OnlyLeftBack"
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
        return arrDepartments.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let departmentObj = arrDepartments.object(at: row) as! DepartmentI
        
        return departmentObj.departmentName?.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        departmentObj = arrDepartments.object(at: row) as? DepartmentI
        
//        selectedDepartmentNo =  departmentObj.departmentNo?.description
        
    }
    
    // MARK: - Custom Functions
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        
        //Temp Code
        /*
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question4") as! Question4
        self.navigationController?.pushViewController(myVC, animated: true)
        
        return
        */
        
        if(validateData())
        {
            if((departmentObj?.masterDepartmentNo == 1) || (departmentObj?.masterDepartmentNo == 2))
            {
                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question4") as! Question4
                self.navigationController?.pushViewController(myVC, animated: true)
            }
            else
            {
                ModelManager.sharedInstance.questionManager.dictQuestion["question4"] = "0" as AnyObject
                
                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question5") as! Question5
                self.navigationController?.pushViewController(myVC, animated: true)
            }

        }
        
        
    }
    
    
    
    @IBAction func clkDone(_ sender: Any) {
        
        if((departmentObj == nil) && (arrDepartments.count > 0))
        {
            departmentObj = arrDepartments.object(at: 0) as? DepartmentI
        }
        
    
        ModelManager.sharedInstance.questionManager.dictQuestion["question3"] = departmentObj as AnyObject
        
        txtDepartment.text = departmentObj?.departmentName?.description
        
        
        pickerSuperView.isHidden = true
    }
    
    func validateData()->Bool {
        
        if(txtDepartment.text == "")
        {
            ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter product department")
            
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
