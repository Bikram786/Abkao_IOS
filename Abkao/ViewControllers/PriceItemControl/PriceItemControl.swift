//
//  PriceItemControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class PriceItemControl: AbstractControl {

    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_ProductName: UITextField!
    @IBOutlet weak var txt_ProductPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
    }

    func setStartingFields() {
        
        // upperView.upperdraw(upperView.bounds)
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_ProductName.addShadowToTextfield()
        txt_ProductPrice.addShadowToTextfield()
        
    }
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    
    @IBAction func btn_SaveAction(_ sender: UIButton) {
        
        if (txt_ProductName.text?.isEmpty)! || (txt_ProductPrice.text?.isEmpty)! {
            
        }else{
            var  dictData : [String : Any] =  [String : Any]()
            dictData["product_name"] = txt_ProductName.text!
            dictData["product_price"] = txt_ProductPrice.text!
            dictData["userid"] = "5"
            
            ModelManager.sharedInstance.priceCellManager.addNewRecord(userInfo: dictData) { (userObj, isSuccess, strMessage) in
                
                if(isSuccess)
                {
                    
                    
                }
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
