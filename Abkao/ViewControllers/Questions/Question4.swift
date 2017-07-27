//
//  Question4.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Question4: AbstractControl,UITextFieldDelegate {

    
    @IBOutlet weak var setViewShadow: UIView!

    
    @IBOutlet weak var txtContainerSize: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewShadow.viewdraw(setViewShadow.bounds)

        // Do any additional setup after loading the view.
        
        txtContainerSize.addShadowToTextfield()
        txtContainerSize.delegate = self
        
        txtContainerSize.text = ModelManager.sharedInstance.questionManager.dictQuestion["question4"] as? String
    }

    override var navTitle: String {
        
        return "OnlyLeftBack"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: -
    

    
    
    
    // MARK: - Click Actions
    
    @IBAction func clkNext(_ sender: UIButton) {
        
        if(validateData())
        {               
            ModelManager.sharedInstance.questionManager.dictQuestion["question4"] = txtContainerSize.text as AnyObject
            
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question5") as! Question5
            self.navigationController?.pushViewController(myVC, animated: true)
        }
    }
    
    func validateData()->Bool {
        
        if(txtContainerSize.text == "")
        {
            ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter container size")
            
            
            return false
        }
        
        return true
        
    }
    
    
    // MARK: - TextFiels Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        
    {
        if string == "" {return true}
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "1234567890.")) == nil ? false : true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
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
