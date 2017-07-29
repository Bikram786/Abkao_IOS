//
//  Question5.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Question5: AbstractControl,UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var btnCheckBox: UIButton!

    @IBOutlet weak var txtPromotion: UITextField!
    @IBOutlet weak var setViewShadow: UIView!

    @IBOutlet weak var pickerSuperView: UIView!
    @IBOutlet weak var viewPicker: UIPickerView!
    
    var objPromotion : PromotionI?
    var arrPromotions : NSMutableArray = NSMutableArray()
    
    var isChecked : Bool = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewShadow.viewdraw(setViewShadow.bounds)
        
        txtPromotion.addShadowToTextfield()
        
        viewPicker.dataSource = self
        viewPicker.delegate = self
        
        
        objPromotion = ModelManager.sharedInstance.questionManager.dictQuestion["question5"] as? PromotionI
        
        txtPromotion.text = objPromotion?.name
        
        txtPromotion.isUserInteractionEnabled = true

        
        if(txtPromotion.text == "No Thanks")
        {
            objPromotion = nil
            txtPromotion.isUserInteractionEnabled = false
            isChecked = true
            txtPromotion.text = ""
            btnCheckBox.setImage(UIImage(named: "tick.png"), for: UIControlState.normal)
        }

        ModelManager.sharedInstance.questionManager.getAllPromotions
            { (arrPromotions, isSuccess, msg) in
                
            self.arrPromotions.addObjects(from: arrPromotions!)
            self.viewPicker.reloadAllComponents()

        }
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
        return arrPromotions.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let promotionObj = arrPromotions.object(at: row) as! PromotionI
        
        return promotionObj.name?.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        objPromotion = arrPromotions.object(at: row) as? PromotionI
        
    }
    
    // MARK: - Custom Functions
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        if(validateData())
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question6") as! Question6
            self.navigationController?.pushViewController(myVC, animated: true)
        }
        
    }
    
    
    
    @IBAction func clkDone(_ sender: Any) {
        
        if((objPromotion == nil) && (arrPromotions.count > 0))
        {
            objPromotion = arrPromotions.object(at: 0) as? PromotionI
        }

        ModelManager.sharedInstance.questionManager.dictQuestion["question5"] = objPromotion as AnyObject
        
        txtPromotion.text = objPromotion?.name?.description
        
        pickerSuperView.isHidden = true
    }
    
     @IBAction func clkbtnCheck(_ sender: Any) {
        
        if(isChecked)
        {
            btnCheckBox.setImage(UIImage(named: "untick.png"), for: UIControlState.normal)
            txtPromotion.isUserInteractionEnabled = true
            isChecked = false
        }
        else
        {
            btnCheckBox.setImage(UIImage(named: "tick.png"), for: UIControlState.normal)

            objPromotion = nil
            isChecked = true
            txtPromotion.isUserInteractionEnabled = false
            txtPromotion.text = ""
        ModelManager.sharedInstance.questionManager.dictQuestion["question5"] = "No Thanks" as AnyObject
            
        }
    }
    
    
    func validateData()->Bool {
        
        if(!isChecked)
        {
            if(txtPromotion.text == "")
            {
                ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter promotion discount")
                
                
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
