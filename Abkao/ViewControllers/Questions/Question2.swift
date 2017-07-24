//
//  Question2.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Question2: AbstractControl, UIPickerViewDelegate, UIPickerViewDataSource {

    var arrPrices : NSMutableArray = NSMutableArray()

    
    @IBOutlet weak var txtProductPrice: UITextField!
    @IBOutlet weak var setViewShadow: UIView!


    @IBOutlet weak var pickerSuperView: UIView!
    
    
    @IBOutlet weak var viewPicker: UIPickerView!
    
    
    var selectedPrice : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtProductPrice.text = ModelManager.sharedInstance.questionManager.dictQuestion["question2"] as? String

        
        setViewShadow.viewdraw(setViewShadow.bounds)

        txtProductPrice.addShadowToTextfield()

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
    
    // MARK: - Custom Functions
    
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question3") as! Question3
        self.navigationController?.pushViewController(myVC, animated: true)
        
    }

    
    
    @IBAction func clkDone(_ sender: Any) {
        
        ModelManager.sharedInstance.questionManager.setValue(selectedPrice, forKey: "question2")
        
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
