//
//  Question5.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Question5: AbstractControl,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var txtPromotion: UITextField!
    @IBOutlet weak var setViewShadow: UIView!

    @IBOutlet weak var pickerSuperView: UIView!
    @IBOutlet weak var viewPicker: UIPickerView!
    
    var objPromotion : PromotionI?
    var arrPromotions : NSMutableArray = NSMutableArray()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewShadow.viewdraw(setViewShadow.bounds)
        
        txtPromotion.addShadowToTextfield()
        
        viewPicker.dataSource = self
        viewPicker.delegate = self
        
        txtPromotion.text = ModelManager.sharedInstance.questionManager.dictQuestion["question5"] as? String

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
        
        return promotionObj.price?.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        objPromotion = arrPromotions.object(at: row) as? PromotionI
        
    }
    
    // MARK: - Custom Functions
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question6") as! Question6
        self.navigationController?.pushViewController(myVC, animated: true)
        

        
    }
    
    
    
    @IBAction func clkDone(_ sender: Any) {
        
        if(arrPromotions.count > 0)
        {
            objPromotion = arrPromotions.object(at: 0) as? PromotionI
        }
        
        ModelManager.sharedInstance.questionManager.dictQuestion["question5"] = objPromotion?.price?.description as AnyObject
        
        txtPromotion.text = objPromotion?.price?.description
        
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
